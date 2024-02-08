extends Node3D
class_name HitboxComponent

@export var suspicionComponent : SuspicionComponent
@export var healthComponent : HealthComponent
@export var fearComponent : FearComponent

var isScary := false



func Damage(damage : float, object : Node3D):
	if suspicionComponent:
		suspicionComponent.TriggerSuspiciousStateFromObject(object)
		
	if fearComponent:
		fearComponent.HitWithObject()
		
	if healthComponent:
		healthComponent.Damage(damage)
