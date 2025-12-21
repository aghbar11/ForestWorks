extends Node2D

signal pressed
signal unpressed
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var four_pressed = false
@onready var area_2d: Area2D = $Area2D
@onready var pressed_sound: AudioStreamPlayer2D = $pressed_sound

func _ready() -> void:
	animated_sprite.play("unpressed")

func _on_area_2d_body_entered(body: Node2D) -> void:
	animated_sprite.play("pressed")
	pressed_sound.play()
	owner.enter_button(get_index())


func unpress_buttons():
	animated_sprite.play("unpressed")
	
	

func _on_area_2d_body_exited(body: Node2D) -> void:
	
	pass
