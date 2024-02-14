extends State
class_name Investigate

@export var human : CharacterBody3D
@export var head : Head

var location : Vector3
var objectOfInterest : Node3D
var inspectTimer : float

func Enter():
	inspectTimer = 2.0

func Update(delta : float):
	if inspectTimer > 0:
		inspectTimer -= delta
	else:
		Transitioned.emit(self, "Search")
		pass

func PhysicsUpdate(_delta : float):
	head.look_at(location)
