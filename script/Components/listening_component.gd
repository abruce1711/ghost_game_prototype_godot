extends Node
class_name ListeningComponent

@onready var human = get_parent() as Human
@onready var suspicionComponent = human.get_node("SuspicionComponent") as SuspicionComponent
@onready var fearComponent = human.get_node("FearComponent") as FearComponent


func _ready():
	Events.connect("makeSound", _on_sound_heard)

func _on_sound_heard(volume, location):
	var distanceToSound = human.global_position.distance_to(location)

	if distanceToSound / 2 <= volume:

		var roomOfInterest : Room
		var rooms = get_tree().get_nodes_in_group("rooms")
		for room in rooms:
			if room is Room && room.soundLocation:
				roomOfInterest = room as Room

		if suspicionComponent:
			suspicionComponent.InvestigateNoise(location, roomOfInterest.IsInRoom(human.global_position))
		
		if fearComponent:
			fearComponent.HeardNoise()
