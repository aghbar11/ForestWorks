extends Node2D

@export var animated_sprite : AnimatedSprite2D
@export var sequence : Array[int]

var stack = []

func _process(delta):
	if stack.size() >= 4:
		stack.resize(0)
		get_tree().call_group("buttons", "unpress_buttons")

func enter_button(value):
	if !stack.has(value):
		stack.push_back(value)
		print(stack)
		
	if animated_sprite == null:
		return
	
	if stack == sequence:
		animated_sprite.open_door()
	else:
		animated_sprite.close_door()
