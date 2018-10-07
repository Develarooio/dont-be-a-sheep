extends KinematicBody2D

var speed = 500
var default_speed = 500
var is_transforming = false
export(bool) var sheep
var dash_speed = 1100
var can_dash = true
onready var dash_label = get_node("DashLabel")
onready var dash_cooldown = get_node("DashCooldown")
onready var dash_length = get_node("DashLength")

signal player_died

func _ready():
	sheep = false
	pass

func _physics_process(delta):
	if can_dash:
		dash_label.text = "CAN DASH: TRUE"
	else:
		dash_label.text = "CAN DASH: FALSE"
	dash()
	move()
	set_form()

func dash():
	if Input.is_action_pressed("dash") and can_dash:
		can_dash = false
		speed = dash_speed
		dash_length.start()
		dash_cooldown.start()
	
func get_shape():
	if sheep:
		return shape_owner_get_shape(1, 0)
	else:
		return shape_owner_get_shape(0, 0)

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
	
	if !is_transforming:
		move_and_slide(direction.normalized() * speed)

func set_form():
	if Input.is_action_just_pressed("toggle_form") and !is_transforming:
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
		
		is_transforming = true
		$TransformTimer.start()
		$AnimationPlayer.play("player-transformation")

func get_position():
	if sheep:
		return $Sheep.global_position
	else:
		return $Human.global_position

func kill():
	emit_signal('player_died')
	queue_free()

func _on_DashCooldown_timeout():
	can_dash = true

func _on_DashLength_timeout():
	speed = default_speed

func _on_TransformTimer_timeout():
	is_transforming = false
