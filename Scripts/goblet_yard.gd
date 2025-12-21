extends Node2D
@onready var label: Label = $Label
@onready var hero: CharacterBody2D = $hero
var enemy = preload("res://Scenes/enemy_1.tscn")
@onready var easter_egg_2: Label = $easterEgg2
@onready var easter_egg: Area2D = $easterEgg
var rand = RandomNumberGenerator.new()
var circular_angle := 0.0
@onready var timer: Timer = $Timer
@onready var rebound_timer: Timer = $rebound_timer
var rebound_time_finish = false
@onready var next_stage: Area2D = $next_stage
var can_go_to_next_stage = false
@onready var go_to_next_stage: Control = $go_to_next_stage
@onready var goblet_yard_begninnig: Control = $goblet_yard_begninnig
@onready var next_stage_2: Timer = $next_stage2


func _ready():
	Global.current_scene = "goblet_yard"
	label.text = "🪙: " + str(Global.coin_counter)
	go_to_next_stage.visible = false
	goblet_yard_begninnig.visible
	await get_tree().create_timer(10).timeout
	goblet_yard_begninnig.queue_free()
	timer.start()
	next_stage_2.start()

	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.transition_scene = true



func _process(delta: float) -> void:
	change_scene()
	if Global.player_dead and !rebound_time_finish:
		get_tree().call_group("Enemies", "apply_rebound_from_player", hero.global_position)
	

func change_scene():
	if Global.transition_scene:
		TransitionScenes.transition()
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/dugeon_dirst.tscn")
		Global.finish_changing_scene()


func _on_coin_coin_taken() -> void:
	Global.coin_counter += 1
	label.text = "🪙: " + str(Global.coin_counter)


func _on_timer_timeout() -> void:
	if Global.player_dead:
		timer.queue_free()
		return
	var enemy_instance = enemy.instantiate()
	var random = rand.randf()
	if random > 0.5:
		enemy_instance.global_position.y = -130
		enemy_instance.global_position.x = -160
	else:
		enemy_instance.global_position.y = 130
		enemy_instance.global_position.x = 160
	add_child(enemy_instance)


func _on_easter_egg_body_entered(body: Node2D) -> void:
	if body.has_method("play_damage"):
		easter_egg_2.visible = true
		await get_tree().create_timer(5).timeout
		if is_instance_valid(easter_egg):
			easter_egg.queue_free()
		if is_instance_valid(easter_egg_2):
			easter_egg_2.queue_free()


func _on_hero_player_died() -> void:
	if Global.player_dead:
		rebound_timer.start()
	await get_tree().create_timer(1).timeout
	Global.health = 100
	TransitionScenes.transition()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
	Global.player_dead = false


func _on_rebound_timer_timeout() -> void:
	rebound_time_finish = true


func _on_next_stage_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if can_go_to_next_stage:
			Global.transition_scene = true
			


func _on_next_stage_2_timeout() -> void:
	can_go_to_next_stage = true
	if is_instance_valid(timer):
		timer.queue_free()
	go_to_next_stage.visible = true
