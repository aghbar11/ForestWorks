extends Node

var coin_counter = 0


var player_current_attack = false

var current_scene = "world"
var transition_scene = false
var health = 100
var player_dead = false

func finish_changing_scene():
	if transition_scene:
		transition_scene = false
		if current_scene == "world":
			current_scene = "goblet_yard"
		elif current_scene == "goblet_yard":
			current_scene = "dugeon_dirst"
		elif current_scene == "dugeon_dirst":
			current_scene = "final_scene"
