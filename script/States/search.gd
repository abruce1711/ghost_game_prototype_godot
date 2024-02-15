extends State
class_name Search

@export var human : CharacterBody3D
@export  var moveSpeed : float
@export var text : Label3D
@export var head : Head

var moveDirection : Vector3
var wanderTime := 0.0
var nearWallTimer := 0.0
var nearWall := false

func Enter():
	pass
	
func Update(delta : float):
	if wanderTime > 0:
		wanderTime -= delta
	else:
		Wander(delta)
	if nearWallTimer > 0 && nearWall:
		nearWallTimer -= delta
	elif nearWallTimer <= 0 && nearWall:
		nearWall = false


func PhysicsUpdate(delta : float):
	if !nearWall:
		human.velocity = human.velocity.lerp(moveDirection * moveSpeed, delta)
	else:
		human.velocity.x *= 0.9
	human.rotation.y = lerp(human.rotation.y, -moveDirection.x*1.55, delta)


func Wander(delta : float):
	if wanderTime > 0:
		wanderTime -= delta
	else:
		moveDirection = Vector3(randf_range(-1, 1), 0, 0).normalized()
		wanderTime = randf_range(10, 20)

func _on_sight_component_near_wall():
	moveDirection.x *= -1
	nearWallTimer = 1
	nearWall = true

func _on_fear_component_scared():
	Transitioned.emit(self, "scared")
