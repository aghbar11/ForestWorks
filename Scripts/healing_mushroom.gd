extends Sprite2D

var in_area = false
@onready var healing: AudioStreamPlayer2D = $healing
@onready var area_2d: Area2D = $Area2D

func _process(delta: float) -> void:
	if in_area:
		if Input.is_action_just_pressed("f"):
			healing.play()
			Global.health += 20
			visible = false
			area_2d.monitoring = false
			await get_tree().create_timer(0.5).timeout
			queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		in_area = true
		


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		in_area = false
