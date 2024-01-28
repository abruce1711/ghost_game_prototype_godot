extends Node3D
class_name HitboxComponent

@export var healthComponent : HealthComponent

func Damage(damage : float):
	if healthComponent:
		healthComponent.Damage(damage)
