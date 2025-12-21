extends AnimatedSprite2D

var increase_size = 1.5
var is_increasing = false
var damage = 20
const SPEED = 100

func _ready() -> void:
	play("start")

func _process(delta: float) -> void:
	if is_increasing:
		scale += Vector2(delta * increase_size, delta * increase_size)

func _physics_process(delta: float) -> void:
	velocity.y = SPEED
	move_and_slide()
	


func _on_stop_increasing_timeout() -> void:
	is_increasing = true
	play("pre_shoot")
	await get_tree().create_timer(0.5).timeout
	play("shoot")
