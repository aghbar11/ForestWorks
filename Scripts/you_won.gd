extends Node2D
@onready var you_won_sound: AudioStreamPlayer2D = $you_won_sound


func _ready():
	AudioStreamPlayer2d.enabled = false
	you_won_sound.play()
