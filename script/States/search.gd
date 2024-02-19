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

@export var ap  : AnimationPlayer

func Enter():
	#ap.play("walk")
	human.velocity = Vector3(1.99, 0, 0)
	at["parameters/walk_stop_blend/blend_amount"] = turnBlend
	
func Update(delta : float):
	if turnCoolDown > 0:
		turnCoolDown -= delta

	if wanderTime > 0:
		wanderTime -= delta
	else:
		Wander(delta)



func PhysicsUpdate(delta : float):
	human.velocity = human.velocity.lerp(moveDirection * moveSpeed, delta)
	human.rotation.y = lerp(human.rotation.y, -moveDirection.x*1.55, delta*2)

	if stopping && turnBlend < 0:
		turnBlend += delta
		at["parameters/walk_stop_blend/blend_amount"] = turnBlend
	elif stopping && turnBlend >= 0:
		stopping = false
		TurnAround()
	elif turning && turnBlend <= 1:
		turnBlend += delta
		at["parameters/walk_stop_blend/blend_amount"] = turnBlend
	elif turning && turnBlend >= 1:
		Walk()
	elif !turning && !stopping && turnBlend > -1:
		moveSpeed = abs(turnBlend * lastSpeed)
		turnBlend -= delta
		at["parameters/walk_stop_blend/blend_amount"] = turnBlend
	# elif turnBlend == -1:
	# 	ap.speed_scale = moveSpeed / 2
		


func Wander(delta : float):
	if wanderTime > 0:
		wanderTime -= delta
	else:
		StopWalking()

func _on_sight_component_near_wall():
	StopWalking()

func StopWalking():
	moveSpeed = 0.001
	stopping = true
	#ap.play("stop-walking")

func TurnAround():
	if turnCoolDown <= 0:
		human.velocity = Vector3.ZERO
		turning = true
		#ap.play("left-turn-still")
		turnCoolDown = 5
		moveDirection.x *= -1
		turnTimer = 1
		wanderTime = randf_range(10, 20)

func Walk():
	#ap.play("walk")
	moveSpeed = 2
	#human.velocity = Vector3(1.99*moveDirection.x, 0, 0)
	turning = false

func _on_fear_component_scared():
	Transitioned.emit(self, "scared")


func _on_animation_player_animation_finished(anim_name):
		if anim_name == "stop-walking":
			human.velocity = Vector3.ZERO
			await get_tree().create_timer(0.5).timeout
			TurnAround()
		elif anim_name == "left-turn-still":
			Walk()
