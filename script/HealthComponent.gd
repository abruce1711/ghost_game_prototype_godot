extends Node3D
class_name HealthComponent

var MAX_HEALTH := 20
var health : float

# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH
	
func Damage(damage : float):
	health -= damage
	print_debug("Damaged, current health: %s" % health)
	if health <= 0:
		get_parent().queue_free()
