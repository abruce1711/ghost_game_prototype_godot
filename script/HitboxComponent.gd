extends Node3D
class_name HitboxComponent

@export var healthComponent : HealthComponent

var isScary := false

func Damage(damage : float):
	if healthComponent:
		healthComponent.Damage(damage)
