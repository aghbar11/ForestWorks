extends Node2D
@onready var exer: Sprite2D = $exer
@export var boss: CharacterBody2D
@onready var potion: Sprite2D = $potion
var fade_in = 1.5
var boss_dead = false
var message_appear = false

var closed = true
func _ready() -> void:
	exer.frame = 0
	potion.visible = true
	potion.modulate.a = 0.0


func _process(delta: float) -> void:
	if !closed:
		open_box()
		
	if message_appear:
		potion.modulate.a += delta / fade_in

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "hero" and boss_dead:
		print("hello")
		closed = false
	
func open_box():
	if Input.is_action_just_pressed("f"):
		exer.frame = 1
		message_appear = true
		await get_tree().create_timer(5).timeout
		TransitionScenes.transition()
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/world_2.tscn")
		Global.finish_changing_scene()


func _on_boss_dead() -> void:
	boss_dead = true
