extends State
class_name HumanIdleState

@export var human : CharacterBody3D
@export var head : Head
@export  var moveSpeed := 1.0

## Body
var moveDirection : Vector3
var wanderTime : float

func RandomizeWander():
	moveDirection = Vector3(randf_range(-1, 1), 0, 0).normalized()
	wanderTime = randf_range(100, 100)
	#head.SetHeadDirection(moveDirection.x)
	
func Enter():
	RandomizeWander()
	
func Update(delta : float):
	if wanderTime > 0:
		wanderTime -= delta
	else:
		RandomizeWander()
		
func PhysicsUpdate(_delta : float):
	if human:
		MoveAround()
		
func _on_sight_component_near_wall():
	moveDirection.x *= -1
	#head.SetHeadDirection(moveDirection.x)

func _on_fear_component_scared():
	Transitioned.emit(self, "scared")

func MoveAround():
	human.velocity = moveDirection * moveSpeed
	human.rotation.y = lerp(human.rotation.y, -moveDirection.x*1.55, 0.1)
