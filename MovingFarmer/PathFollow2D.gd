extends PathFollow2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var SPEED = 4
var IS_PLAYER_SEEN = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if (!$Farmer.can_see_player):
		offset = offset + SPEED
