extends CharacterBody2D

@onready var animate: AnimatedSprite2D = $AnimatedSprite2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var timer: Timer = $Timer
@onready var hero: CharacterBody2D = $"../hero"
var death_direction = Vector2.ZERO
@onready var stop_rebound: Timer = $stop_rebound
@onready var zombie_hurt: AudioStreamPlayer2D = $zombie_hurt
@onready var zombie_dead: AudioStreamPlayer2D = $zombie_dead


var SPEED = 100
var health = 100
var damage = 50

var dead = false
var hit = false
var rebound_mode = false
var can_animate = true


func _ready():
	animate.play("s_idle")
	await get_tree().create_timer(1).timeout


func _physics_process(delta: float) -> void:
	if rebound_mode:
		move_and_slide()
		return
	if dead:
		play_animation(death_direction)
		return
	if can_animate:
		navigation_agent_2d.target_position = hero.global_position
		var current_position = global_position
		var next_path_position = navigation_agent_2d.get_next_path_position()
		var velocity = current_position.direction_to(next_path_position) * SPEED
		var direction = current_position.direction_to(next_path_position).normalized()

		if navigation_agent_2d.avoidance_enabled:
			navigation_agent_2d.set_velocity(velocity)
		else:
			_on_navigation_agent_2d_velocity_computed(velocity)
		move_and_slide()
		play_animation(direction)

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	

func play_animation(direction):
	var dir = get_direction_string(direction)
		
	if hit and !dead:
		play_damage(dir + "_damage")
	elif dead:
		animate.play(dir + "_death")
		await get_tree().create_timer(1).timeout
		queue_free()
	else:
		animate.play(dir + "_walk")


func get_direction_string(direction: Vector2) -> String:
	var x = direction.x
	var y = direction.y
	if y <= -0.5:
		return "nw" if x <= -0.5 else "ne" if x >= 0.5 else "n"
	elif y > 0.5:
		return "sw" if x <= -0.5 else "se" if x >= 0.5 else "s"
	return "w" if x <= -0.5 else "e" if x >= 0.5 else "s"




func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.has_method("arrow"):
		hit = true
		area.visible = false
		health -= damage
		if health == 0:
			zombie_dead.play()
			SPEED = 0
			dead = true
			var current_position = global_position
			var next_path_position = navigation_agent_2d.get_next_path_position()
			death_direction = current_position.direction_to(next_path_position).normalized()
		else:
			zombie_hurt.play()
		timer.start()


func _on_timer_timeout() -> void:
	hit = false
	SPEED = 100
	
func play_damage(animation: String) -> void:
	SPEED = 0
	animate.play(animation)
	

func apply_rebound_from_player(player_position: Vector2):
	var direction = (global_position - player_position).normalized()
	velocity = direction * 350
	rebound_mode = true
	stop_rebound.start()


func _on_stop_rebound_timeout() -> void:
	rebound_mode = false
	can_animate = false
	queue_free()
