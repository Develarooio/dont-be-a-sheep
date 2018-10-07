extends Node2D

var current_level = 1
var level_directory = ('res://Levels/Level%s.tscn')
var current_level_node

func _ready():
	switch_level(1)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

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