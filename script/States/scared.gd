extends State
class_name Scared

@export var text : Label3D
@export var human : Human

var moveDirection : Vector3
var movementSpeed := 5.0

var targetRoom : Room
var zUnlocked := false

func Enter():
	if text:
		text.text = "ahhh !!!"

	var doors = get_tree().get_nodes_in_group("exitDoors")

	# main is ending up in the group for some reason so this removes is
	for door in doors:
		if !door is Door:
			doors.erase(door)

	# this removes doors on another floor for now, will revisit when I add stairs
		elif abs(door.global_position.y - human.global_position.y) > 2:
			doors.erase(door)

	doors.sort_custom(sortClosestExitDoor)
	var exitDoor = doors[0] as Door

	var rooms = get_tree().get_nodes_in_group("rooms")

	for room in rooms:
		if !room is Room:
			rooms.erase(room)
		elif room.IsInRoom(exitDoor.global_position):
			targetRoom = room
			break

	moveDirection = (exitDoor.global_position - human.global_position).normalized()
	
func Exit():
	pass;
	
func Update(_delta: float):
	pass;
	
func PhysicsUpdate(_delta: float):
	if targetRoom.IsInRoom(human.global_position) && !zUnlocked:
		zUnlocked = true
		human.axis_lock_linear_z = false


	human.velocity = moveDirection * movementSpeed
	human.rotation.y = lerp(human.rotation.y, -moveDirection.x*1.55, 0.1)


func sortClosestExitDoor(a : Node3D, b : Node3D):
	return (human.global_position.distance_squared_to(a.global_position) <
	human.global_position.distance_squared_to(b.global_position))
