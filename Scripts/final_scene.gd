extends Node2D

var fire_ball = preload("res://Scenes/fire_ball_character.tscn")
@onready var boss: CharacterBody2D = $boss
@onready var timer: Timer = $Timer
@onready var hero: CharacterBody2D = $hero
@onready var fire_ball_sound: AudioStreamPlayer2D = $fire_ball_sound

func _ready() -> void:
	Global.current_scene = "final_scene"
	hero.scale = Vector2(1, 1)

func _on_timer_timeout() -> void:
	var fire_ball_instance = fire_ball.instantiate()
	if is_instance_valid(boss):
		fire_ball_instance.global_position = Vector2(boss.global_position.x, boss.global_position.y + 50)
		fire_ball_sound.play()
		add_child(fire_ball_instance)
	



func _on_hero_player_died() -> void:
		Global.health = 100
		TransitionScenes.transition()
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
		Global.finish_changing_scene()
		Global.player_dead = false


func _on_final_scene_dialogue_chat_stopped() -> void:
	timer.start()
