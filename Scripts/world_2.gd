extends Node2D

@onready var label: Label = $Label

func _ready():
	label.text = "🪙: " + str(Global.coin_counter)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_coin_coin_taken() -> void:
	Global.coin_counter += 1
	label.text = "🪙: " + str(Global.coin_counter)





func _on_another_dialogue_chat_stopped() -> void:
		await get_tree().create_timer(2).timeout
		TransitionScenes.transition()
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/you_won.tscn")
		Global.finish_changing_scene()
