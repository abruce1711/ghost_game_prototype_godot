extends Node
class_name SightComponent

@export var rayCast : RayCast3D
@export var head : Head
@onready var human = get_parent() as Human

var wallTimer := 0.0
var powerTimer := 0.0
var canStillSeePower := false

signal nearWall
signal canSeePower(fear : float)

func _process(delta):
	if wallTimer > 0:
		wallTimer -= delta
	
	if powerTimer > 0:
		powerTimer -= delta

func _physics_process(_delta):
	if rayCast && rayCast.is_colliding() && rayCast.get_collider() is StaticBody3D:
		var distanceToWall = rayCast.global_transform.origin.distance_to(rayCast.get_collision_point())
		if distanceToWall < 2 && wallTimer <= 0:
			wallTimer = 1
			nearWall.emit()


func _on_sight_body_entered(body):
	var sightCollision = SightRaycast(body)

	if sightCollision is Power:
		var power = (sightCollision as Power)
		if powerTimer <= 0 && power.activated:
			powerTimer = 5
			canSeePower.emit(power.fearValue, power)
			head.SetLookAtPower(power)


func SightRaycast(node : Node3D):
	var spaceState = node.get_world_3d().direct_space_state
	var rayOrigin = human.global_position
	var rayEnd = node.global_position

	## last param here is binary representation of layer mask, layers 1,2,3, and 4
	var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd, 0b1111)

	var ray = spaceState.intersect_ray(query)
	
	if ray:
		return ray.collider
