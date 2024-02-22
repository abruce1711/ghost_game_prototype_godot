extends State
class_name Investigate

signal turnAround

@export var human : Human

var location : Vector3
var objectOfInterest : Node3D
var stateTimer : float
var decelerationSpeed := 3.0
var inSameRoom : bool
var targetRot : float
var noiseBehind := false

func Enter():
	super()
	stateTimer = 5.0
	targetRot = -human.rotation_degrees.y

	if inSameRoom:
		# location is behind human
		if (human.rotation_degrees.y < 0 && location.x < human.global_position.x) || (human.rotation_degrees.y > 0 && location.x > human.global_position.x):
			noiseBehind = true
	else:
		animationPlayer.StopRunning()

# func Update(delta : float):
# 	if stateTimer > 0:
# 		stateTimer -= delta
# 	else:
# 		Transitioned.emit(self, "Search")

func PhysicsUpdate(delta : float):
	if inSameRoom && noiseBehind:
		human.rotation_degrees.y = lerp(human.rotation_degrees.y, targetRot, 5 * delta)
	elif inSameRoom && !noiseBehind:
		pass
		#head.look_at(location)

	if human.velocity.x > 0:
		human.velocity.x -= delta * decelerationSpeed
	elif human.velocity.x < 0:
		human.velocity.x += delta * decelerationSpeed


func _on_animation_player_animation_finished(anim_name):
	if anim_name == Animations.StopRunning:
		human.velocity = Vector3.ZERO
		animationPlayer.LookAround()
	elif anim_name == Animations.LookAround:
		animationPlayer.Shrug()
		turnAround.emit()
	elif anim_name == Animations.Shrug:
		Transitioned.emit(self, "Search")
