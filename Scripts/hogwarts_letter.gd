extends Area2D


@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var blank_hogwarts_letter_2: Sprite2D = $BlankHogwartsLetter2
@onready var button: Button = $RichTextLabel/Button

var player_in_range = false
var fade_in = false
var fade_speed = 1.5
var pressed = false

func _ready():
	rich_text_label.modulate.a = 0.0
	rich_text_label.visible = true
	blank_hogwarts_letter_2.modulate.a = 0.0
	blank_hogwarts_letter_2.visible = true





func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("f"):
		fade_in = true


	if fade_in and rich_text_label.modulate.a < 1:
		blank_hogwarts_letter_2.modulate.a += _delta / fade_speed
		rich_text_label.modulate.a += _delta / fade_speed
	if pressed:
		blank_hogwarts_letter_2.modulate.a -= _delta / fade_speed
		rich_text_label.modulate.a -= _delta / fade_speed




func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = true


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = false


func _on_button_pressed() -> void:
		pressed = true
		fade_in = false
		await get_tree().create_timer(1.5).timeout
		pressed = false
