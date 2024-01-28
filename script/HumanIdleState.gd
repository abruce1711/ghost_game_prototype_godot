extends State
class_name HumanIdleState

const MIN_FEAR = 0
const MAX_FEAR = 100

@export var human : CharacterBody3D
@export  var moveSpeed := 1.0
@export var rayCast : RayCast3D
@export var FEAR_JUMP := 1.0
@onready var smooth_dir = human.position

var moveDirection : Vector3
var wanderTime : float
var distanceToWall : float
var fearLevel := 0.0
var turnTimer = 0

func RandomizeWander():
	moveDirection = Vector3(randf_range(-1, 1), 0, 0).normalized()
	wanderTime = randf_range(5, 15)
	
func Enter():
	RandomizeWander()
	
func Update(delta : float):
	if wanderTime > 0:
		wanderTime -= delta
	else:
		RandomizeWander()
		
func PhysicsUpdate(delta : float):
	if human:
		human.velocity = moveDirection * moveSpeed
		human.rotation.y = lerp(human.rotation.y, -moveDirection.x*1.55, 0.1)

	if !rayCast.is_colliding():
		return
	
	CheckGhostCollision()
	
	if !rayCast.get_collider() is StaticBody3D:
		return
		
	distanceToWall = rayCast.global_transform.origin.distance_to(rayCast.get_collision_point())
	if distanceToWall < 2 && turnTimer <= 0:
		moveDirection.x *= -1
		turnTimer = 3
	elif turnTimer > 0:
		turnTimer -= delta
		
func CheckGhostCollision():
	var collision = rayCast.get_collider()
	
	if (collision is HitboxComponent
	&& (collision as HitboxComponent).isScary):
		IncreaseFear()
	else:
		DecreaseFear()
	
func IncreaseFear():
	if fearLevel >= MAX_FEAR:
		Transitioned.emit(self, "scared")
		return
		
	fearLevel += FEAR_JUMP
	
func DecreaseFear():
	if fearLevel > MIN_FEAR && fearLevel < MAX_FEAR:
		fearLevel -= FEAR_JUMP/2
			
		
