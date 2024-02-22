extends Node3D
class_name Head

var lookY : float
var lookX : float
var lookTimer := 2.0
var lookSpeed := 2

var powerToLookat : Power
var stareTimer := 0.0

func _ready():
	SetRotation()

func _process(delta):
	if lookTimer > 0:
		lookTimer -= delta
	else:
		SetRotation()
		lookTimer = 2

func _physics_process(delta):
	pass
	#self.rotation = self.rotation.lerp(Vector3(0, 0, lookY), delta * lookSpeed)

func SetRotation():
	lookY = deg_to_rad(randf_range(-60, 60))
	lookX = deg_to_rad(randf_range(-10, 45))
