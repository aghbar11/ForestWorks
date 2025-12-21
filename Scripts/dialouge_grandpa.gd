extends Control

@export_file("res://Grandfather_dialoug.json") var d_file
signal chat_start
signal chat_stopped

var dialouge = []
var current_dialouge_id = 0

func _ready():
	start()
	
func start():
	emit_signal("chat_start")
	dialouge = load_dialouge()
	current_dialouge_id = -1
	next_script()
		
func load_dialouge():
	var file = FileAccess.open("res://Grandfather_dialoug.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content
	
	
func _input(event):
		if event.is_action_pressed("ui_accept"):
			next_script()
			

func next_script():
	current_dialouge_id += 1
	if current_dialouge_id >= len(dialouge):
		$NinePatchRect.visible = false
		emit_signal("chat_stopped")
		return
	
	$NinePatchRect/Name.text = dialouge[current_dialouge_id]["name"]
	$NinePatchRect/Text.text = dialouge[current_dialouge_id]["text"]
