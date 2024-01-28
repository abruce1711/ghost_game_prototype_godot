extends State
class_name HumanIdleState

@export var human : CharacterBody3D
@export  var moveSpeed := 1.0
@onready var smooth_dir = human.position

var moveDirection : Vector3
var wanderTime : float

func RandomizeWander():
	moveDirection = Vector3(randf_range(-1, 1), 0, 0).normalized()
	wanderTime = randf_range(5, 10)
	
func Enter():
	RandomizeWander()
	
func Update(delta : float):
	if wanderTime > 0:
		wanderTime -= delta
	else:
		RandomizeWander()
		
func PhysicsUpdate(delta : float):
	if human:
		human.velocity = moveDirection * moveSpeed
		var min_angle = deg_to_rad(0.0)
		var max_angle = deg_to_rad(180.0)
		human.rotation.y = lerp(human.rotation.y, -moveDirection.x*1.55, 0.1)
			
		
