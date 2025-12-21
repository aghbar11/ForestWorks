extends Control
@onready var game_over_sound: AudioStreamPlayer2D = $game_over_sound


func _ready():
	AudioStreamPlayer2d.enabled = false
	game_over_sound.play()
	
func _on_button_pressed() -> void:
	AudioStreamPlayer2d.enabled = true
	AudioStreamPlayer2d.playing = true
	TransitionScenes.transition()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/" + Global.current_scene + ".tscn")
