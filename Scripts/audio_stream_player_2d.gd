extends AudioStreamPlayer2D

var enabled = true
var play = false

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if !enabled:
		self.autoplay = false
		self.playing = false
