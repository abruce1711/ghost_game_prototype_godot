extends State
class_name HumanSuspiciousState

@export var human : CharacterBody3D
@export  var moveSpeed := 3.0
@export var text : Label3D

var moveDirection : Vector3
var wanderTime : float
var suspicionTimer := 0.0


func RandomizeWander():
	moveDirection = Vector3(randf_range(-1, 1), 0, 0).normalized()
	wanderTime = randf_range(5, 10)
	
func Enter():
	suspicionTimer = 10
	if text:
		text.text = "??"
	RandomizeWander()
	
func Update(delta : float):
	if wanderTime > 0:
		wanderTime -= delta
	else:
		RandomizeWander()
		
	if suspicionTimer > 0:
		suspicionTimer -= delta
		print_debug("sus timer: %s" % suspicionTimer)
	else:
		text.text = ""
		Transitioned.emit(self, "idle")
		
func PhysicsUpdate(_delta : float):
	if human:
		human.velocity = moveDirection * moveSpeed
		human.rotation.y = lerp(human.rotation.y, -moveDirection.x*1.55, 0.1)
			
		
func _on_sight_component_near_wall():
	print_debug("near wall signal received")
	moveDirection.x *= -1

func _on_fear_component_scared():
	Transitioned.emit(self, "scared")


func _on_suspicion_component_suspicious():
	suspicionTimer = 10
