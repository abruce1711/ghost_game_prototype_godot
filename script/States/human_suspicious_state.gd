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
var arrivedAtSuspiciousLocation := false
var suspiciousObject : Node3D
var suspiciousObjectTimer := 0.0
	
func Enter():
	suspicionTimer = 1000
	if text:
		text.text = "??"

	moveSpeed = 3.0
	GoToSupiciousLocation()

func Update(delta : float):
	if arrivedAtSuspiciousLocation:
		Wander(delta)

	if suspicionTimer > 0:
		suspicionTimer -= delta
	else:
		text.text = ""
		Transitioned.emit(self, "idle")

	if suspiciousObjectTimer > 0:
		suspiciousObjectTimer -= delta
	elif suspiciousObject:
		suspiciousObject = null	


func PhysicsUpdate(_delta : float):
	if human:
		human.velocity = moveDirection * moveSpeed
		human.rotation.y = lerp(human.rotation.y, -moveDirection.x*1.55, 0.1)

		if !arrivedAtSuspiciousLocation && DistanceToSuspiciousLocation() < 0.1:
			arrivedAtSuspiciousLocation = true
			moveSpeed = 1.5
		elif arrivedAtSuspiciousLocation && DistanceToSuspiciousLocation() > 5:
			arrivedAtSuspiciousLocation = false
			GoToSupiciousLocation()
			head.look_at(suspiciousLocation)
		
		if suspiciousObject:
			head.look_at(suspiciousObject.global_position)
		elif suspicionTimer <= 0:
			suspicionTimer = 3
			head.look_at(suspiciousLocation)

func DistanceToSuspiciousLocation():
	return human.global_position.distance_to(Vector3(suspiciousLocation.x, human.global_position.y, human.global_position.z))


func RandomizeWander():
	moveDirection = Vector3(randf_range(-1, 1), 0, 0).normalized()
	wanderTime = randf_range(5, 10)
	#head.SetHeadDirection(moveDirection.x)


func Wander(delta : float):
	if wanderTime > 0:
		wanderTime -= delta
	else:
		RandomizeWander()

func GoToSupiciousLocation():
	arrivedAtSuspiciousLocation = false
	
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

func _on_suspicion_component_suspicious():
	suspicionTimer = 10
