extends Area2D

var direction
var speed = 10

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func set_direction(dir):
	direction = dir
	
func _physics_process(delta):
	print(collision_layer)
	position = position + (direction * speed)
