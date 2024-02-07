extends Node3D
class_name HitboxComponent

signal wasHit(object : Node3D)

@export var healthComponent : HealthComponent

var isScary := false

func Damage(damage : float, object : Node3D):
	if get_parent() is Human:
		wasHit.emit(object)
		
	if healthComponent:
		healthComponent.Damage(damage)
