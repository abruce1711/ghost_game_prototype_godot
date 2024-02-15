extends Node
class_name FearComponent

const MIN_FEAR = 0
const MAX_FEAR = 100

@onready var human = get_parent() as Human
@onready var stateMachine = human.get_node("StateMachine") as StateMachine

@export var fearBar : ProgressBar3D

var fearLevel := 0.0

func _on_sight_component_can_see_power(fear : float, _power):
	SetFear(fear)


func HitWithObject():
	fearLevel += 30
	fearBar.SetValue(fearLevel)
	
	if fearLevel >= MAX_FEAR:
		TransitionToScared()


func HeardNoise():
	SetFear(10)


func SetFear(fear : float):
	fearLevel += fear
	fearBar.SetValue(fearLevel)
	
	if fearLevel >= MAX_FEAR:
		TransitionToScared()


func TransitionToScared():
	var state = stateMachine.currentState
	state.Transitioned.emit(state, "Scared")
