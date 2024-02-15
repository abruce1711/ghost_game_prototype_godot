extends State
class_name CanSeePower

@export var human : CharacterBody3D
@export var text : Label3D
@export var head : Head

var power : Power

var moveDirection : Vector3
var wanderTime : float

func Enter():
	human.velocity = Vector3.ZERO

func Update(_delta : float):
	pass


func PhysicsUpdate(_delta : float):
	if power.activated:
		head.look_at(power.global_position)
	else:
		Transitioned.emit(self, "investigate")

func _on_fear_component_scared():
	Transitioned.emit(self, "scared")
