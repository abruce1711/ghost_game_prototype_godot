extends Node3D
class_name HitboxComponent

signal wasHit

@export var healthComponent : HealthComponent

var isScary := false

func Damage(damage : float):
	if get_parent() is Human:
		wasHit.emit()
		
	if healthComponent:
		healthComponent.Damage(damage)
