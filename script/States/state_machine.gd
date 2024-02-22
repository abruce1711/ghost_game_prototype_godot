extends Node
class_name StateMachine

@export var initialState : State
@onready var animationPlayer : HumanAnimation = get_node("../AnimationPlayer")

var currentState : State
var states : Dictionary = {}


func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(onChildTransition)
	
	if initialState:
		if !initialState.animationPlayer:
			print_debug("ap: %s" % animationPlayer)
			initialState.animationPlayer = animationPlayer

		initialState.Enter()
		currentState = initialState


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currentState:
		currentState.Update(delta)
		#print_debug(currentState)
		
func _physics_process(delta):
	if currentState:
		currentState.PhysicsUpdate(delta)
		
		
func onChildTransition(state, newStateName):
	if state != currentState:
		return
		
	var newState = states.get(newStateName.to_lower())
	if !newState:
		return
	
	if currentState:
		currentState.Exit()
	
	if !newState.animationPlayer:
		newState.animationPlayer = animationPlayer

	newState.Enter()
	
	currentState = newState
