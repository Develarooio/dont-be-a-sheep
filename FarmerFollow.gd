extends PathFollow2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var SPEED = 10
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	offset = offset + SPEED
	print(offset)