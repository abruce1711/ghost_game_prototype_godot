extends MeshInstance3D
var maxY = deg_to_rad(90)
var minY = deg_to_rad(-90)

var maxX = deg_to_rad(25)
var minX = deg_to_rad(-10)

var lookTimer := 3.0
var lookDirectionY : float
var lookDirectionX : float


func _ready():
	SetLookDir()


func _process(delta):
	if lookTimer > 0:
		lookTimer -= delta
	else:
		SetLookDir()
		lookTimer = 5


func _physics_process(delta):
	if (self as MeshInstance3D).rotation.y >= maxY:
		lookDirectionY = -0.1
	elif (self as MeshInstance3D).rotation.y <= minY:
		lookDirectionY = 0.1
		
	if (self as MeshInstance3D).rotation.x >= maxX:
		lookDirectionX = -0.1
	elif (self as MeshInstance3D).rotation.x <= minX:
		lookDirectionX = 0.1
		
	
		
	self.rotate_y(deg_to_rad(lookDirectionY))
	self.rotate_x(deg_to_rad(lookDirectionX))



func SetLookDir():
	var choiceY = randi() % 2 == 0
	var choiceX = randi() % 2 == 0
	
	if choiceY:
		lookDirectionY = 0.1
	else:
		lookDirectionY = -0.1
		
	if choiceX:
		lookDirectionX = 0.1
	else:
		lookDirectionX = -0.1
