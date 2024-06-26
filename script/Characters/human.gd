extends CharacterBody3D
class_name Human

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(_delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity

	move_and_slide()
