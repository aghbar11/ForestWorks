extends CharacterBody2D


const SPEED = 250
var player_state = true
@onready var animate = $AnimatedSprite2D
var bow_equipped = false
var bow_cooldown = true
var arrow = preload("res://Scenes/arrow.tscn")
@onready var dialouge: Control = $"../Dialouge"
var enemy_hit = false
@onready var progress_bar: ProgressBar = $"../ProgressBar"
var is_hit = false
signal player_died
@onready var arrow_sound: AudioStreamPlayer2D = $Arrow_sound
@onready var hurt: AudioStreamPlayer2D = $hurt

var mouse_loc_from_player = null

func _process(delta: float) -> void:
	progress_bar.value = Global.health

func _physics_process(delta) -> void:
	if !Global.player_dead:
		mouse_loc_from_player = get_global_mouse_position() - self.position
		var direction = Input.get_vector("left","right","up","down")
		if not player_state:
			velocity = Vector2.ZERO
			animate.play("Idle")
			return
		if is_hit:
			hit_animate(direction)
			await get_tree().create_timer(0.1).timeout
			is_hit = false
			return
			
		velocity = direction * SPEED
		move_and_slide()
		play_animation(direction)
		
		if Input.is_action_just_pressed("e"):
			if bow_equipped:
				bow_equipped = false
			else:
				bow_equipped = true
		
		var mouse_position = get_global_mouse_position()
		$Marker2D.look_at(mouse_position)
		
		if Input.is_action_just_pressed("left_mouse") and bow_equipped and bow_cooldown:
			bow_cooldown = false
			var arrow_instance = arrow.instantiate()
			arrow_instance.rotation = $Marker2D.rotation
			arrow_instance.global_position = $Marker2D.global_position
			add_child(arrow_instance)
			arrow_sound.play()
			
			
			await get_tree().create_timer(0.6).timeout
			bow_cooldown = true
	else:
		player_gone()
		await get_tree().create_timer(1).timeout
	
func play_animation(direction):
	if !bow_equipped:
		
		if direction == Vector2.ZERO:
			animate.play("Idle")
		if direction.y == -1:
			animate.play("walk_n") 
		if direction.y == 1:
			animate.play("walk_s")
		if direction.x == 1:
			animate.play("walk_e")	
		if direction.x == -1:
			animate.play("walk_w")
			
		if direction.x > 0.5 and direction.y < -0.5:
			animate.play("walk_n_e")
		if direction.x > 0.5 and direction.y > 0.5:
			animate.play("walk_s_e")
		if direction.x < -0.5 and direction.y > 0.5:
			animate.play("walk_s_w")
		if direction.x < -0.5 and direction.y < -0.5:
			animate.play("walk_n_w")
	if bow_equipped:
		if mouse_loc_from_player.x >= 25 and mouse_loc_from_player.x <= 25 and mouse_loc_from_player.y < 0:
			$AnimatedSprite2D.play("n-attack")
		if mouse_loc_from_player.y >= -25 and mouse_loc_from_player.y <= 25 and mouse_loc_from_player.x > 0:
			$AnimatedSprite2D.play("e-attack")
		if mouse_loc_from_player.x >= 25 and mouse_loc_from_player.x <= 25 and mouse_loc_from_player.y > 0:
			$AnimatedSprite2D.play("s-attack")
		if mouse_loc_from_player.y >= -25 and mouse_loc_from_player.y <= 25 and mouse_loc_from_player.x < 0:
			$AnimatedSprite2D.play("w-attack")
		
		if mouse_loc_from_player.x >= 25 and mouse_loc_from_player.y <= -25:
			$AnimatedSprite2D.play("ne-attack")
		if mouse_loc_from_player.x >= 0.5 and mouse_loc_from_player.y >= 25:
			$AnimatedSprite2D.play("se-attack")
		if mouse_loc_from_player.x <= -0.5 and mouse_loc_from_player.y >= 25:
			$AnimatedSprite2D.play("sw-attack")
		if mouse_loc_from_player.x <= -25 and mouse_loc_from_player.y <= -25:
			$AnimatedSprite2D.play("nw-attack")
func player():
	pass
	
func hit_animate(direction: Vector2):
		if direction == Vector2.ZERO:
			animate.play("Idle")
		if direction.y == -1:
			animate.play("n_hit") 
		if direction.y == 1:
			animate.play("s_hit")
		if direction.x == 1:
			animate.play("e_hit")	
		if direction.x == -1:
			animate.play("w_hit")
			
		if direction.x > 0.5 and direction.y < -0.5:
			animate.play("ne_hit")
		if direction.x > 0.5 and direction.y > 0.5:
			animate.play("se_hit")
		if direction.x < -0.5 and direction.y > 0.5:
			animate.play("sw_hit")
		if direction.x < -0.5 and direction.y < -0.5:
			animate.play("nw_hit")
	


func _on_dialouge_chat_start() -> void:
	player_state = false
	



func _on_dialouge_chat_stopped() -> void:
	player_state = true
	dialouge.visible = false





func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("play_damage"):
		hurt.play()
		Global.health -= 10
		progress_bar.value = Global.health
		if Global.health == 0:
			Global.player_dead = true
			emit_signal("player_died")
		is_hit = true
		
func player_gone():
	animate.play("n_hit")



func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "fire_ball_character":
		hurt.play()
		Global.health -= 10
		progress_bar.value = Global.health
		if Global.health == 0:
			Global.player_dead = true
			emit_signal("player_died")
		is_hit = true
