extends Node
class_name HealthComponent

var MAX_HEALTH := 100
var health : float
@export var healthBar : ProgressBar3D

# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH
	
func Damage(damage : float):
	health -= damage
	healthBar.SetValue(health)
	if health <= 0:
		get_parent().queue_free()
