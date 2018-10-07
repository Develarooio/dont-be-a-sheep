extends Node2D

var current_level = 1
var level_directory = ('res://Levels/Level%s.tscn')
var current_level_node
var paused = true
var max_level = 2
var game_over = false

func _ready():
	game_start()

func _process(delta):
	if paused:
		if Input.is_action_pressed("ui_accept"):
			if game_over:
				switch_level(1)
			else:
				switch_level(current_level)
			hide_message()
			paused = false
		if game_over and Input.is_action_pressed("quit"):
			get_tree().quit()

func game_start():
	show_message("press enter to start")

func _game_over_win():
	show_level(0)
	if current_level == max_level:
		game_over = true
		show_message("You beat the game! \n Press enter to play again, press q to quit")
	else:
		show_message("You beat level " + str(current_level) + " press enter to continue")
	paused = true
	current_level = current_level + 1


func switch_level(level):
	current_level = level
	show_level(level)
	
func show_level(level):
	if current_level_node:
		current_level_node.queue_free()
	current_level_node = load(get_level_resource_path(level)).instance()
	add_child(current_level_node)
	current_level_node.get_winspot().connect("win", self, "_game_over_win")

func get_level_resource_path(level_int):
	return level_directory % (level_int)

func show_message(message):
	$UI/MessageBox.set_message(message)
	$UI/MessageBox.visible = true

func hide_message():
	$UI/MessageBox.visible = false