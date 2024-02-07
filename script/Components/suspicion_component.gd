extends Node
class_name SuspicionComponent
const  MAX_SUSPICION = 100

@onready var human = get_parent() as Human
@export var fearComponent : FearComponent

signal suspicious

func _on_sight_component_can_see_power(_fear : float):
		suspicious.emit()

func _on_hitbox_was_hit(object : Node3D):
	if fearComponent.fearLevel < fearComponent.MAX_FEAR:

		var stateMachine = human.get_node("StateMachine") as StateMachine
		var state = stateMachine.currentState

		if state is HumanIdleState or state is HumanSuspiciousState:
			var suspiciousState = stateMachine.get_node("Suspicious")
			suspiciousState.suspiciousObject = object
			suspiciousState.suspiciousLocation = object.global_position
			suspiciousState.suspiciousObjectTimer = 3
			
			state.Transitioned.emit(state, "suspicious")

		suspicious.emit()
