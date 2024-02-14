extends State
class_name HumanSuspiciousStateNew

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
var roomOfInterest : Room
var inRoomOfInterest : bool

func Enter():
	if text:
		text.text = "??"

	moveSpeed = 3.0
	lookTimer = 3.0
	arrivedAtSuspiciousLocation = false

	var rooms = get_tree().get_nodes_in_group("rooms")
	for room in rooms:
		if room is Room && room.soundLocation:
			roomOfInterest = room as Room
			

	if roomOfInterest:
		print_debug("going to room")
		SetRoomDirection()


func Update(delta : float):
	if suspicionTimer > 0:
		suspicionTimer -= delta
	else:
		text.text = ""
		Transitioned.emit(self, "idle")


func PhysicsUpdate(_delta : float):
	if human:
		human.velocity = moveDirection * moveSpeed
		human.rotation.y = lerp(human.rotation.y, -moveDirection.x*1.55, 0.1)


func Wander(delta : float):
	if wanderTime > 0:
		wanderTime -= delta
	else:
		moveDirection = Vector3(randf_range(-1, 1), 0, 0).normalized()
		wanderTime = randf_range(5, 10)


func SetRoomDirection():
	var moveX : int
	if roomOfInterest.center < human.global_position.x:
		moveX = -1
	else:
		moveX = 1

	moveDirection = Vector3(moveX, 0, 0).normalized()

func TravelToRoom():
	var roomLoc = human.global_position


func _on_sight_component_near_wall():
	moveDirection.x *= -1

func _on_fear_component_scared():
	Transitioned.emit(self, "scared")
