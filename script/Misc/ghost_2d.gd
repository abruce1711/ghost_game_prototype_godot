extends CharacterBody3D
class_name Ghost2D
const SPEED = 5.0
@export var sprite : Sprite3D
@export var light : OmniLight3D
@export var hitBox : HitboxComponent

var isVisible = false

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "down", "up")
	var direction = (transform.basis * Vector3(input_dir.x,input_dir.y, 0)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func GhostVisible():
	sprite.modulate.a = 255
	light.light_energy = 2
	hitBox.isScary = true
	
func GhostInvisible():
	sprite.modulate.a = 255
	light.light_energy = 1
	hitBox.isScary = false
