extends Node

@export var rayCast : RayCast3D

var wallTimer := 0.0
var powerTimer := 0.0

signal nearWall
signal canSeePower(fear : float)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	if wallTimer > 0:
		wallTimer -= delta
	
	if powerTimer > 0:
		powerTimer -= delta
		
	if !rayCast || !rayCast.is_colliding():
		return
	
	var collision = rayCast.get_collider()
	
	if collision is Power:
		var power = (collision as Power)
		
		if powerTimer <= 0 && power.activated:
			powerTimer = 5
			canSeePower.emit(power.fearValue)
		return
		
	if collision is StaticBody3D:
		var distanceToWall = rayCast.global_transform.origin.distance_to(rayCast.get_collision_point())
		if distanceToWall < 2 && wallTimer <= 0:
			wallTimer = 1
			nearWall.emit()
