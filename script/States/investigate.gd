extends State
class_name Investigate

@export var human : Human
@export var head : Head

var location : Vector3
var objectOfInterest : Node3D
var stateTimer : float
var decelerationSpeed := 3.0
var inSameRoom : bool
var targetRot : float
var noiseBehind := false

func Enter():
	stateTimer = 5.0
	head.lookSpeed = 3
	targetRot = -human.rotation_degrees.y

	if inSameRoom:
		# location is behind human
		if (human.rotation_degrees.y < 0 && location.x < human.global_position.x) || (human.rotation_degrees.y > 0 && location.x > human.global_position.x):
			noiseBehind = true

func Update(delta : float):
	if stateTimer > 0:
		stateTimer -= delta
	else:
		Transitioned.emit(self, "Search")
		head.lookSpeed = 1

func PhysicsUpdate(delta : float):
	if inSameRoom && noiseBehind:
		human.rotation_degrees.y = lerp(human.rotation_degrees.y, targetRot, 5 * delta)
	elif inSameRoom && !noiseBehind:
		head.look_at(location)

	if human.velocity.x > 0:
		human.velocity.x -= delta * decelerationSpeed
	elif human.velocity.x < 0:
		human.velocity.x += delta * decelerationSpeed
