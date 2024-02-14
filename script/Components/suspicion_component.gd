extends Node
class_name SuspicionComponent

@onready var human = get_parent() as Human
@onready var fearComponent = human.get_node("FearComponent") as FearComponent
@onready var stateMachine = human.get_node("StateMachine") as StateMachine

func _on_sight_component_can_see_power(_fear, power : Power):
	CanSeePower(power)


# func TriggerSuspiciousStateFromObject(object : Node3D):
# 	if fearComponent.fearLevel < fearComponent.MAX_FEAR:
# 		var state = stateMachine.currentState

# 		if state is HumanIdleState or state is HumanSuspiciousState:
# 			var suspiciousState = stateMachine.get_node("Suspicious")
# 			suspiciousState.suspiciousObject = object
# 			suspiciousState.suspiciousLocation = object.global_position
# 			suspiciousState.suspicionTimer = 100
			
# 			state.Transitioned.emit(state, "suspicious")


# func TriggerSuspiciousStateFromLocation(location : Vector3):
# 	var state = stateMachine.currentState

# 	if state is HumanIdleState or state is HumanSuspiciousState:
# 		var suspiciousState = stateMachine.get_node("Suspicious")
# 		suspiciousState.suspiciousLocation = location
# 		suspiciousState.suspicionTimer = 100
# 		state.Transitioned.emit(state, "suspicious")


func InvestigateNoise(location : Vector3):
	var investigateState = stateMachine.get_node("Investigate")
	(investigateState as Investigate).location = location

	var state = stateMachine.currentState
	state.Transitioned.emit(state, "MoveToRoom")


func StruckWithObject(object : Node3D):
	var investigateState = stateMachine.get_node("Investigate")
	(investigateState as Investigate).objectOfInterest = object

	var state = stateMachine.currentState
	state.Transitioned.emit(state, "Investigate")

func CanSeePower(power : Power):
	var investigateState = stateMachine.get_node("Power")
	(investigateState as CanSeePower).power = power

	var state = stateMachine.currentState
	state.Transitioned.emit(state, "CanSeePower")
