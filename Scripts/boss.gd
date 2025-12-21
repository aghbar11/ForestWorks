extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var health_bar : ProgressBar
@onready var hurt: AudioStreamPlayer2D = $hurt


const SPEED = 200
const LEFT_BOUNDARY = -250
const RIGHT_BOUNDARY = 200
var health = 200
var can_move = true
var moving_right = true
signal dead
var initial_pause = true

func _ready() -> void:
	health_bar.value = health
	
func _process(delta: float) -> void:
	health_bar.value = health

func _physics_process(delta: float) -> void:
	if !initial_pause:
		if can_move:
			if moving_right:
				velocity.x = SPEED
				if global_position.x >= RIGHT_BOUNDARY:
					moving_right = false
			else:
				velocity.x = -SPEED
				if global_position.x <= LEFT_BOUNDARY:
					moving_right = true
			
			move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.has_method("arrow"):
		hurt.play()
		can_move = false
		health -= 10
		if health <= 0:
			death_animation()
		else:
			hit_animation()
		
func hit_animation():
	animated_sprite_2d.play("hit")
	await get_tree().create_timer(0.1).timeout
	animated_sprite_2d.play("default")
	can_move = true
	
func death_animation():
	animated_sprite_2d.play("hit")
	await get_tree().create_timer(0.5).timeout 
	animated_sprite_2d.play("vanish")
	await get_tree().create_timer(1).timeout 
	emit_signal("dead")
	queue_free()


func _on_final_scene_dialogue_chat_stopped() -> void:
	initial_pause = false
	
