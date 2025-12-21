extends CanvasLayer

signal on_transition_finished
@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	color_rect.visible = false
	on_transition_finished.connect(_on_transition_finished)
	
	
func transition():
	color_rect.visible = true
	animation_player.play("fade_out")
	await get_tree().create_timer(0.5).timeout
	on_transition_finished.emit()

func _on_transition_finished():
	animation_player.play("fade_in")
