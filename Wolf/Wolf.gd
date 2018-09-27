extends KinematicBody2D

var direction = Vector2(0,0)
var speed = 400

func _process(delta):
	move_and_slide(direction * speed)
	direction = Vector2(0,0)

func _on_AgroArea_sheep_detected(sheep_position):
	direction = Vector2(sheep_position - position).normalized()