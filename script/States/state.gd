extends Node
class_name State
var animationPlayer : HumanAnimation

signal Transitioned

var active := false

func Enter():
	active = true

func Exit():
	active = false
	
func Update(_delta: float):
	pass;
	
func PhysicsUpdate(_delta: float):
	pass;
