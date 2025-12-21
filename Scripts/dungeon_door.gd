extends AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D
@onready var door_open: AudioStreamPlayer2D = $"../door_open"


func open_door():
	play("open_door")
	door_open.play()
	if is_instance_valid(collision_shape_2d):
		collision_shape_2d.queue_free()
	
func close_door():
	play("close_door")
