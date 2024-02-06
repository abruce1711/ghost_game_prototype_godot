extends State
class_name HumanIdleState

@export var human : CharacterBody3D
@export  var moveSpeed := 1.0

var moveDirection : Vector3
var wanderTime : float

func RandomizeWander():
	moveDirection = Vector3(randf_range(-1, 1), 0, 0).normalized()
	wanderTime = randf_range(30, 100)
	
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
		human.rotation.y = lerp(human.rotation.y, -moveDirection.x*1.55, 0.1)
			
		
func _on_sight_component_near_wall():
	print_debug("near wall signal received")
	moveDirection.x *= -1

func _on_fear_component_scared():
	Transitioned.emit(self, "scared")
