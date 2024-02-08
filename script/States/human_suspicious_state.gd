extends State
class_name HumanSuspiciousState

@export var human : CharacterBody3D
@export  var moveSpeed := 3.0
@export var text : Label3D
@export var head : Head

var moveDirection : Vector3
var wanderTime : float
var suspicionTimer := 0.0
var suspiciousLocation : Vector3
var arrivedAtSuspiciousLocation : bool
var suspiciousObject : Power
var lookTimer : float
var looking : bool 
	
func Enter():
	if text:
		text.text = "??"

	print_debug("enter: %s" % suspiciousLocation)
	moveSpeed = 3.0
	lookTimer = 3.0
	arrivedAtSuspiciousLocation = false
	looking = true
	head.lookSpeed = 0.5
	GoToSupiciousLocation()

func Update(delta : float):
	if suspicionTimer > 0:
		suspicionTimer -= delta
	else:
		text.text = ""
		Transitioned.emit(self, "idle")


func PhysicsUpdate(delta : float):
	if human:
		human.velocity = moveDirection * moveSpeed
		human.rotation.y = lerp(human.rotation.y, -moveDirection.x*1.55, 0.1)

		if !arrivedAtSuspiciousLocation && DistanceToSuspiciousLocation() < 1:
			arrivedAtSuspiciousLocation = true
			moveSpeed = 1.5
		elif suspiciousObject && suspiciousObject.activated:
			moveSpeed = 0
		elif arrivedAtSuspiciousLocation && lookTimer > 0:
			moveSpeed = 0
			lookTimer -= delta
		elif arrivedAtSuspiciousLocation && lookTimer <= 0:
			Wander(delta)
			moveSpeed = 2
			suspiciousObject = null
			looking = false
		
		if suspiciousObject:
			head.look_at(suspiciousObject.global_position)
		elif suspiciousLocation && looking:
			head.look_at(suspiciousLocation)

func DistanceToSuspiciousLocation():
	return human.global_position.distance_to(Vector3(suspiciousLocation.x, human.global_position.y, human.global_position.z))

func ClearSuspicions():
	suspiciousLocation = Vector3()


func Wander(delta : float):
	if wanderTime > 0:
		wanderTime -= delta
	else:
		moveDirection = Vector3(randf_range(-1, 1), 0, 0).normalized()
		wanderTime = randf_range(5, 10)

func GoToSupiciousLocation():
	var moveX : int
	if suspiciousLocation.x < human.global_position.x:
		moveX = -1
	else:
		moveX = 1

	moveDirection = Vector3(moveX, 0, 0).normalized()
	#head.SetHeadDirection(moveDirection.x)


func _on_sight_component_near_wall():
	moveDirection.x *= -1

func _on_fear_component_scared():
	Transitioned.emit(self, "scared")
