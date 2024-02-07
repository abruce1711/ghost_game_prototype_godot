extends RigidBody3D
class_name Power

var enabled : bool = true
var activated : bool = false
var distanceToGhost : float
var distanceToMouse : float
var mousePos : Vector3
var fearValue := 10.0
var powerTimer = 0

@onready var ghost : Ghost = get_parent().get_node("Ghost")

func Process(_delta : float):
	if powerTimer > 0:
		powerTimer -= _delta
		
	mousePos = MousePosition()
	distanceToMouse = self.global_position.distance_to(mousePos)
	distanceToGhost = self.global_position.distance_to(ghost.global_position)
	
func _input(event):
	if (event.is_action_pressed("power") && distanceToGhost < 5 && distanceToMouse < 1 && !activated && powerTimer <= 0):
		powerTimer = 0.1
		activated = true
	elif (event.is_action_pressed("power") && activated && powerTimer <= 0):
		powerTimer = 0.1
		activated = false

func MousePosition():
	var mousePosition = get_viewport().get_mouse_position()
	var spaceState = get_world_3d().direct_space_state
	var camera = get_tree().root.get_camera_3d()
	var rayOrigin = camera.project_ray_origin(mousePosition)
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePosition) * 2000
	var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	var rayArray = spaceState.intersect_ray(query)
	if (rayArray.has("position")):
		var responsePosition = rayArray["position"]
		responsePosition.z = -1
		return responsePosition
	return Vector3()
