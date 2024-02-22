extends State
class_name CanSeePower

@export var human : CharacterBody3D
@export var text : Label3D
@export var headContainer : Node3D

var power : Power

var moveDirection : Vector3
var wanderTime : float

func Enter():
	human.velocity = Vector3.ZERO
	animationPlayer.play("surprised")

func Update(_delta : float):
	pass


func PhysicsUpdate(_delta : float):
	if power.activated:
		human.velocity = Vector3.ZERO
		#headContainer.look_at(power.global_position)

	else:
		Transitioned.emit(self, "investigate")

func _on_fear_component_scared():
	Transitioned.emit(self, "scared")


# func LookAt(global_target_pos: Vector3):
# 	var target_pos = skeleton.to_local(power.global_transform.origin)
# 	#var target_pos = -(power.global_transform.origin * skeleton.global_transform)
# 	print_debug(target_pos)
# 	var pose : Transform3D = skeleton.get_bone_global_pose(head)
# 	pose = pose.orthonormalized()
# 	var pose_new = pose.looking_at(target_pos)
# 	pose_new = pose_new.orthonormalized()
# 	pose_new.basis = pose_new.basis.rotated(pose_new.basis.x, deg_to_rad(5))
# 	skeleton.set_bone_pose_rotation(head, pose_new.basis)
