extends Node3D
class_name FearComponent

const MIN_FEAR = 0
const MAX_FEAR = 100

signal scared

@export var fearBar : ProgressBar3D

var fearLevel := 0.0

func _on_sight_component_can_see_power(fear : float, _suspicionLevel : float):
	fearLevel += fear
	fearBar.SetValue(fearLevel)
	
	if fearLevel >= MAX_FEAR:
		scared.emit()


func _on_hitbox_was_hit():
	fearLevel += 20
	fearBar.SetValue(fearLevel)
	
	if fearLevel >= MAX_FEAR:
		scared.emit()
