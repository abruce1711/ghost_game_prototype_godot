extends State
class_name Search

@export var human : CharacterBody3D
@export  var moveSpeed : float
@export var text : Label3D
@export var head : Head
@export var rayCast : RayCast3D
@export var model : Node3D
@export var at : AnimationTree

var moveDirection := Vector3(1, 0, 0).normalized()
var wanderTime := 10.0
var turnTimer := 0.0
var turning := false
var stopping := false
var lastMoveDir : Vector3
var turnBlend := -1.0
var turnCoolDown := 0.0
var lastSpeed = moveSpeed
var lastRotation : float

@export var ap  : AnimationPlayer

func Enter():
	ap.play("walking")
	human.velocity = Vector3(1.99, 0, 0)
	
func Update(delta : float):
	if turnCoolDown > 0:
		turnCoolDown -= delta

	if wanderTime > 0:
		wanderTime -= delta
	else:
		Wander(delta)


func PhysicsUpdate(delta : float):
	human.velocity = human.velocity.lerp(moveDirection * moveSpeed, delta)

	if turning:
		human.rotation.y = lerp(human.rotation.y, -moveDirection.x*1.55, delta*2)

		if moveDirection.x == -1:
			ap.play("left-turn-in-place")
		elif moveDirection.x == 1:
			ap.play("right-turn-in-place")

		if (lastRotation < 0 && human.rotation.y >= 1.5) || (lastRotation > 0 && human.rotation.y <= -1.5):
			turning = false
			print_debug("last rotation: %s" % lastRotation)
			print_debug("current rotation: %s" % human.rotation.y)

			ap.play("walking")
			human.velocity = Vector3(1.99*moveDirection.x, 0, 0)
			moveSpeed = 2
		

func Wander(delta : float):
	if wanderTime > 0:
		wanderTime -= delta
	# else:
	# 	StopWalking()


func _on_sight_component_near_wall():
		StopWalking()


func StopWalking():
	if turnCoolDown <= 0:
		ap.play("stop-walking", 1)
		moveSpeed = 0
		turnCoolDown = 5


func TurnAround():
	turning = true
	moveDirection.x *= -1
	wanderTime = randf_range(10, 20)
	lastRotation = human.rotation.y


func _on_fear_component_scared():
	Transitioned.emit(self, "scared")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "stop-walking":
		human.velocity = Vector3.ZERO
		TurnAround()