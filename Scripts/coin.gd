extends Node2D


var player_in_area = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var coin_2: Node2D = $"."
@onready var label: Label = $"../Label"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	animated_sprite_2d.play("coin")


func _process(delta: float) -> void:
	if player_in_area:
		player_in_area = false
		visible = false
		area_2d.monitoring = false
		await get_tree().create_timer(0.5).timeout
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.coin_counter += 1
		label.text = "🪙: " + str(Global.coin_counter)
		audio_stream_player_2d.play()
		player_in_area = true
