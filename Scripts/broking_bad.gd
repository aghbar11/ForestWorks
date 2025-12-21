extends Node2D
@onready var label: Label = $Label
@onready var hero: CharacterBody2D = $hero

func _process(delta: float) -> void:
	change_scene()



func _on_transition_to_yard_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.transition_scene = true

func change_scene():
	if Global.transition_scene:
		if Global.current_scene == "world":
			TransitionScenes.transition()
			await get_tree().create_timer(0.5).timeout
			get_tree().change_scene_to_file("res://Scenes/goblet_yard.tscn")
			Global.finish_changing_scene()


func _on_coin_coin_taken() -> void:
	Global.coin_counter += 1
	label.text = "🪙: " + str(Global.coin_counter)
