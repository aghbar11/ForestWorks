extends Node2D
@onready var hero: CharacterBody2D = $hero

func _ready():
	hero.scale = Vector2(1, 1)

func _process(delta: float) -> void:
	change_scene()
	
func change_scene():
	if Global.transition_scene:
		TransitionScenes.transition()
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/final_scene.tscn")
		Global.finish_changing_scene()
		




func _on_next_stage_body_entered(body: Node2D) -> void:
	if body.name == "hero":
		Global.transition_scene = true
