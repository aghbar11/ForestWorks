extends CharacterBody2D
@onready var fire_ball: AnimatedSprite2D = $fire_ball
@onready var timer: Timer = $Timer

var increase_size = 3
var is_increasing = false
var damage = 15
const SPEED = 150

func _ready() -> void:
	fire_ball.play("start")

func _process(delta: float) -> void:
	if is_increasing:
		var scale_delta = delta * increase_size
		fire_ball.scale += Vector2(scale_delta, scale_delta)
	if global_position.y > 250:
		reached_end()
		is_increasing = false
		if is_instance_valid(timer):
			timer.queue_free()

func _physics_process(delta: float) -> void:
	if is_increasing:
		velocity.y = SPEED
		move_and_slide()
	

func reached_end():
	fire_ball.play("destroyed")
	await get_tree().create_timer(1).timeout
	queue_free()

func _on_timer_timeout() -> void:
	fire_ball.play("pre_shoot")
	await get_tree().create_timer(0.2).timeout
	is_increasing = true
	fire_ball.play("shoot")
	
