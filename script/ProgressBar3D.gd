extends Sprite3D
class_name ProgressBar3D

@export var bar : ProgressBar
@export var initialValue := 100.0
@export var styleBox : StyleBoxFlat

# Called when the node enters the scene tree for the first time.
func _ready():
	texture = $SubViewport.get_texture()
	SetValue(initialValue)
	SetStyleBox(styleBox)

func SetStyleBox(sb):
	bar.add_theme_stylebox_override("fill", sb)
		
func SetValue(health : float):
	bar.value  = health
