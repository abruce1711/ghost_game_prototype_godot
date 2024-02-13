extends MeshInstance3D
class_name Head

@export var sight : SightComponent

var maxY := deg_to_rad(20)
var minY := deg_to_rad(-20)
var lookSpeed := 0.2
var maxHeadYAngle = 70

var maxX = deg_to_rad(25)
var minX = deg_to_rad(-10)

var lookTimer := 3.0
var lookDirectionY : float
var lookDirectionX : float

var beingOverridden = false
var powerToLookat : Power
var stareTimer := 0.0

func _process(delta):
	if !beingOverridden:
		if lookTimer > 0:
			lookTimer -= delta
		else:
			SetLookDir()
			lookTimer = 5

func _physics_process(delta):
	if !beingOverridden:
		LookAround()
	elif powerToLookat && powerToLookat.activated:
		LookAtPower()
	elif powerToLookat && !powerToLookat.activated && stareTimer > 0:
		LookAtPower()
		stareTimer -= delta
	else:
		beingOverridden = false

func LookAround():
	if self.rotation.y >= maxY:
		lookDirectionY = -lookSpeed
	elif self.rotation.y <= minY:
		lookDirectionY = lookSpeed
		
	if self.rotation.x >= maxX:
		lookDirectionX = -lookSpeed
	elif self.rotation.x <= minX:
		lookDirectionX = lookSpeed
	
	self.rotate_y(deg_to_rad(lookDirectionY))
	self.rotate_x(deg_to_rad(lookDirectionX))

func LookAtPower():
	var sightCollision = sight.SightRaycast(powerToLookat)

	if sightCollision != powerToLookat:
		beingOverridden = false
	else:
		look_at(powerToLookat.global_position)

func SetLookAtPower(power : Power):
	stareTimer = 3.0
	beingOverridden = true
	powerToLookat = power

func SetLookDir():
	var choiceY = randi() % 2 == 0
	var choiceX = randi() % 2 == 0
	
	if choiceY:
		lookDirectionY = lookSpeed
	else:
		lookDirectionY = -lookSpeed
		
	if choiceX:
		lookDirectionX = lookSpeed
	else:
		lookDirectionX = -lookSpeed

func SetHeadDirection(moveDirection : float):
	if moveDirection > 0:
		maxY = deg_to_rad(maxHeadYAngle)
		minY = deg_to_rad(0)
	else:
		maxY = deg_to_rad(0)
		minY = deg_to_rad(-maxHeadYAngle)
