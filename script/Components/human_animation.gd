extends AnimationPlayer
class_name HumanAnimation

func Walk():
	var suspicionComponent = get_node("../SuspicionComponent") as SuspicionComponent
	if suspicionComponent.suspicous:
		self.play(Animations.SuspiciousWalking, 0.5)
	else :
		self.play(Animations.SuspiciousWalking, 0.5)

func StopWalking():
	self.play(Animations.StopWalking, 1)

func TurnLeft():
	self.play(Animations.TurnLeft)

func TurnRight():
	self.play(Animations.TurnRight)

func Run():
	self.play(Animations.Run)

func StopRunning():
	self.play(Animations.StopRunning)

func LookAround():
	self.play(Animations.LookAround)

func Shrug():
	self.play(Animations.Shrug, 0.5)
