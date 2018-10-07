extends Node2D

var current_level = 1
var level_directory = ('res://Levels/Level%s.tscn')
var current_level_node

func _ready():
	game_start()
	pass

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		#Game start
		switch_level(1)
		hide_message()
		#Switch level
		#Game Over

func game_start():
	show_message("press enter to start")

func _game_over_win():
	switch_level(current_level + 1)

func switch_level(level):
	current_level = level
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