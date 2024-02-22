extends Node
class_name SuspicionComponent

@onready var human = get_parent() as Human
@onready var fearComponent = human.get_node("FearComponent") as FearComponent
@onready var stateMachine = human.get_node("StateMachine") as StateMachine

@onready var suspicous := false

func _on_sight_component_can_see_power(_fear, power : Power):
	CanSeePower(power)


func InvestigateNoise(location : Vector3, inSameRoom : bool):
	var investigateState = stateMachine.get_node("Investigate")
	(investigateState as Investigate).location = location
	(investigateState as Investigate).inSameRoom = inSameRoom

	var state = stateMachine.currentState
	state.Transitioned.emit(state, "MoveToRoom")
	suspicous = true


func StruckWithObject(object : Node3D):
	var investigateState = stateMachine.get_node("Investigate")
	(investigateState as Investigate).objectOfInterest = object

	var state = stateMachine.currentState
	state.Transitioned.emit(state, "Investigate")
	suspicous = true


func CanSeePower(power : Power):
	var canSeePowerState = stateMachine.get_node("CanSeePower")
	(canSeePowerState as CanSeePower).power = power

	var state = stateMachine.currentState
	state.Transitioned.emit(state, "CanSeePower")
	suspicous = true
