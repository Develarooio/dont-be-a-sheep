extends KinematicBody2D

var direction
var speed = 700

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func set_direction(dir):
	direction = dir
	print(direction)
	
func _physics_process(delta):
	move_and_slide(direction * speed)
