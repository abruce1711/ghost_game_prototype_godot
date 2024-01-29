extends Power
class_name GrabObjectPower
var grabbed : bool = false
var originalObjectParent
var grabbedPos
var bobbingUp

@export  var light : Light3D
@export var hitbox : HitboxComponent

func _process(delta):
	## Call base process
	Process(delta)
	
	## Check if object is stuck on wall
	if (activated && distanceToGhost > 10 && self.get_contact_count() > 0):
		hitbox.isScary = false
		activated = false

func _physics_process(delta):
	if (activated && !grabbed):
		Grab()
	elif (!activated && grabbed):
		Release()
	elif (activated && grabbed):
		FollowMouse(delta)
	elif !activated && !grabbed:
		MoveToBackground(delta)

func FollowMouse(delta : float):
	var direction = mousePos - self.global_position
	self.apply_central_force((direction * 10) - (self.get_linear_velocity() * 500) * delta);
	MoveToForeground(delta)

func Grab():
	self.gravity_scale = 0
	grabbedPos = self.position
	light.light_energy = 1
	grabbed = true
	hitbox.isScary = true

func Release():
	self.gravity_scale = 1
	light.light_energy = 0
	grabbed = false
	hitbox.isScary = false
	
func MoveToForeground(delta : float):
	if self.position.z < 0:
		self.position.z += delta
		
func MoveToBackground(delta : float):
	if self.position.z > -1:
			self.position.z -= delta/2

func _on_area_3d_area_entered(area):
	if area is HitboxComponent:
		var areaHitbox : HitboxComponent = area
		areaHitbox.Damage(25)
