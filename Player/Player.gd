extends KinematicBody2D


# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 500
export(bool) var sheep

func _ready():
	sheep = false
	pass

func _physics_process(delta):
	move()
	set_form()
	
func move():
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

func set_form():
	if Input.is_action_just_pressed("toggle_form"):
		$Human.disabled = !$Human.disabled
		$Human.visible = !$Human.visible
		$Sheep.disabled = !$Sheep.disabled
		$Sheep.visible = !$Sheep.visible
		sheep = !sheep
		
		if sheep:
			remove_from_group("humans")
			add_to_group("sheep")
		else:
			remove_from_group("sheep")
			add_to_group("humans")