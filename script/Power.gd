extends RigidBody3D
class_name Power

var enabled : bool = true
var activated : bool = false
var distanceToGhost : float
var distanceToMouse : float
var mousePos : Vector3

@onready var ghost : Ghost = get_parent().get_node("ghost")

func Process(delta : float):
	mousePos = MousePosition()
	distanceToMouse = self.global_position.distance_to(mousePos)
	distanceToGhost = self.global_position.distance_to(ghost.global_position)
	
func _input(event):
	if (event.is_action_pressed("power") && distanceToGhost < 5 && distanceToMouse < 1 && !activated):
		activated = true
		ghost.GhostVisible()
	elif (event.is_action_pressed("power") && activated):
		activated = false
		ghost.GhostInvisible()

func MousePosition():
	var mousePos = get_viewport().get_mouse_position()
	var spaceState = get_world_3d().direct_space_state
	var camera = get_tree().root.get_camera_3d()
	var rayOrigin = camera.project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 2000
	var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	var rayArray = spaceState.intersect_ray(query)
	if (rayArray.has("position")):
		var position = rayArray["position"]
		position.z = -1
		return position
	return Vector3()
