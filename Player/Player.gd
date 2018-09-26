extends KinematicBody2D


# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 500

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	var direction = Vector2()
	if Input.is_action_pressed("move_down"):
		direction.y = 1
	if Input.is_action_pressed("move_up"):
		direction.y = -1
	if Input.is_action_pressed("move_right"):
		direction.x = 1
	if Input.is_action_pressed("move_left"):
		direction.x = -1
	
	move_and_slide(direction.normalized() * speed)