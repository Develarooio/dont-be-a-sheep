extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$Level1.get_winspot().connect("win", self, "_game_over_win")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _game_over_win():
	print("you fuckin won")