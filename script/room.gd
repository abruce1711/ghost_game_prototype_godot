extends Area3D
class_name Room

@onready var roomShape = get_node("Bounds") as CollisionShape3D
@onready var room = self as Area3D

var leftBound : float
var rightBound : float
var center : float

var soundLocation := false

func _ready():
	var roomWidth = roomShape.shape.size.x

	center = room.global_position.x
	print_debug("center of room %s is %s" % [self.name, room.global_position])
	leftBound = center - (roomWidth / 2)
	rightBound = center + (roomWidth / 2)

	Events.connect("makeSound", _on_sound_heard)

	add_to_group("rooms")


func _on_sound_heard(_volume, location):
	if location.x >= leftBound && location.x <= rightBound:
		print_debug("noise in room %s" % self.name)
		soundLocation = true