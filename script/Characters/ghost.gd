extends CharacterBody3D
class_name Ghost
const SPEED = 8.0
const ACCELERATION = 70.0
const DECELERATION = 50.0
@export var material : ORMMaterial3D
@export var light : OmniLight3D
@export var hitBox : HitboxComponent

var isVisible = false

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "down", "up")
	var aim_dir = Input.get_vector("aimLeft", "aimRight", "aimDown", "aimUp").normalized()
	
	var upDown = Input.get_axis("aimUp", "aimDown")
	var leftRight = Input.get_axis("aimLeft", "aimRight")
	var direction = (transform.basis * Vector3(input_dir.x,input_dir.y, 0)).normalized()
	#var aimDirection = (get_viewport().get_mouse_position() * Vector2(aim_dir.x,aim_dir.y)).normalized()

	if direction != Vector3.ZERO:
		var target_velocity = SPEED * direction
		velocity = velocity.move_toward(target_velocity, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector3.ZERO, DECELERATION * delta)
		
	if aim_dir:
		get_viewport().warp_mouse(Vector2(get_viewport().get_mouse_position().x + (leftRight * 8), get_viewport().get_mouse_position().y + (upDown * 8)))

	move_and_slide()

func GhostVisible():
	material.transparency = BaseMaterial3D.TRANSPARENCY_DISABLED
	material.albedo_color.a = 1
	light.light_energy = 2
	hitBox.isScary = true
	
func GhostInvisible():
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.albedo_color.a = 0.5
	light.light_energy = 1
	hitBox.isScary = false
