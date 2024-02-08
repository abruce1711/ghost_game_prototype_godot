extends Node
class_name SoundComponent

@onready var noisyObject = get_parent() as Node3D

var soundTimer := 0.0

func _process(delta):
	if soundTimer > 0:
		soundTimer -= delta

func MakeSound(volume : float):
	if soundTimer <= 0:
		Events.emit_signal("makeSound", volume, noisyObject.global_position)
		soundTimer = 0.5
