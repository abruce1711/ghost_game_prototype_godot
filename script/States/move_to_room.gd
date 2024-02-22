extends State
class_name MoveToRoom

signal setMoveDirection(moveDirection : Vector3)

@export var human : CharacterBody3D
@export  var moveSpeed := 3.0
@export var text : Label3D

var moveDirection : Vector3
var roomOfInterest : Room
var inRoomOfInterest : bool
var roomLocation : Vector3

func Enter():
	super()
	
	if text:
		text.text = "??"
	
	moveSpeed = 3.0

	var rooms = get_tree().get_nodes_in_group("rooms")
	for room in rooms:
		if room is Room && room.soundLocation:
			roomOfInterest = room as Room
			

	if roomOfInterest:
		if HumanInRoom():
			Transition("Investigate")
		else:
			animationPlayer.Run()
			SetRoomDirection()
			setMoveDirection.emit(moveDirection)
	else:
		Transition("Search")


func PhysicsUpdate(_delta : float):
	if HumanInRoom():
		Transition("Investigate")
	else:
		human.velocity = moveDirection * moveSpeed
		human.rotation.y = lerp(human.rotation.y, -moveDirection.x*1.55, 0.1)


func HumanInRoom():
	return human.global_position.x > roomOfInterest.leftBound && human.global_position.x < roomOfInterest.rightBound


func Transition(state):
	Transitioned.emit(self, state)
	roomOfInterest.soundLocation = false

func SetRoomDirection():
	var moveX : int
	if roomOfInterest.center < human.global_position.x:
		moveX = -1
	else:
		moveX = 1

	moveDirection = Vector3(moveX, 0, 0).normalized()
	
	roomLocation = human.global_position
	roomLocation.x = roomOfInterest.center
