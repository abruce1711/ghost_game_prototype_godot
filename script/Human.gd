extends CharacterBody3D
class_name Human

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MIN_FEAR = 0
const MAX_FEAR = 100

@export var rayCast : RayCast3D
@export var FEAR_JUMP := 1.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var fearLevel := 0.0

func _process(delta):
	if rayCast.is_colliding():
		var collisionParent = rayCast.get_collider().get_parent()
		if collisionParent is Ghost:
			print_debug("can see ghost")
			var ghost : Ghost = collisionParent
			if ghost.isVisible:
				IncreaseFear()
		elif collisionParent is GrabObjectPower:
			var object : GrabObjectPower = collisionParent
			if object.activated:
				IncreaseFear()
		elif rayCast.get_collider() is StaticBody3D:
			var distanceToWall = self.global_position.distance_to(rayCast.get_collision_point())
	else:
		DecreaseFear()
				
func IncreaseFear():
	fearLevel += FEAR_JUMP
	print_debug("scared, fear level: %s" % fearLevel)
	if fearLevel >= MAX_FEAR:
		queue_free()
	
func DecreaseFear():
	if fearLevel > MIN_FEAR:
		fearLevel -= FEAR_JUMP
			

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity

	move_and_slide()
