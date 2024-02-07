extends State
class_name HumanScaredState

@export var text : Label3D
@export var human : Human
@export var exitDoor : Door
var moveDirection : Vector3
var movementSpeed := 5.0

func Enter():
	if text:
		text.text = "ahhh !!!"
		
	moveDirection = (exitDoor.global_position - human.global_position).normalized()
	human.axis_lock_linear_z = false
	
func Exit():
	pass;
	
func Update(_delta: float):
	pass;
	
func PhysicsUpdate(_delta: float):
	if human:
		human.velocity = moveDirection * movementSpeed
		human.rotation.y = lerp(human.rotation.y, -moveDirection.x*1.55, 0.1)
