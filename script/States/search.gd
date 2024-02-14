extends State
class_name Search

@export var human : CharacterBody3D
@export  var moveSpeed : float
@export var text : Label3D
@export var head : Head

var moveDirection : Vector3
var wanderTime := 0.0

func Enter():
	pass
	
func Update(delta : float):
	if wanderTime > 0:
		wanderTime -= delta
	else:
		Wander(delta)


func PhysicsUpdate(_delta : float):
	if human:
		human.velocity = moveDirection * moveSpeed
		human.rotation.y = lerp(human.rotation.y, -moveDirection.x*1.55, 0.1)


func Wander(delta : float):
	if wanderTime > 0:
		wanderTime -= delta
	else:
		moveDirection = Vector3(randf_range(-1, 1), 0, 0).normalized()
		wanderTime = randf_range(10, 20)

func _on_sight_component_near_wall():
	moveDirection.x *= -1

func _on_fear_component_scared():
	Transitioned.emit(self, "scared")
