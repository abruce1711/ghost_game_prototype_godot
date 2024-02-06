extends Node3D

const MIN_FEAR = 0
const MAX_FEAR = 100

signal scared

@export var fearBar : ProgressBar3D

var fearLevel := 0.0

func _on_sight_component_can_see_power(fear : float):
	fearLevel += fear
	fearBar.SetValue(fearLevel)
	
	if fearLevel >= MAX_FEAR:
		scared.emit()
