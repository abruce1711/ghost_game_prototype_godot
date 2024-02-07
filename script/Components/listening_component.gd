extends Node
class_name ListeningComponent

@onready var human = get_parent() as Human


func _ready():
	Events.connect("makeSound", _on_sound_heard)

func _on_sound_heard(volume, location):
	var distanceToSound = human.global_position.distance_to(location)

	if distanceToSound / 2 <= volume:
		var stateMachine = human.get_node("StateMachine") as StateMachine
		var state = stateMachine.currentState

		if state is HumanIdleState or state is HumanSuspiciousState:
			var suspiciousState = stateMachine.get_node("Suspicious")
			suspiciousState.suspiciousLocation = location
			state.Transitioned.emit(state, "suspicious")
