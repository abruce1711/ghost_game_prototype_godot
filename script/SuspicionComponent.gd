extends Node3D
class_name SuspicionComponent
const  MAX_SUSPICION = 100

@export var fearComponent : FearComponent

signal suspicious

func _on_sight_component_can_see_power(_fear : float):
		suspicious.emit()

func _on_hitbox_was_hit():
	if fearComponent.fearLevel < fearComponent.MAX_FEAR:
		suspicious.emit()
