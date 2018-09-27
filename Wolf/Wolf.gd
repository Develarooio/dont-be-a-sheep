extends KinematicBody2D

var direction = Vector2(0,0)
var speed = 400
onready  var ray = get_node("Ray")

func _process(delta):
	move_and_slide(direction * speed)
	direction = Vector2(0,0)

func _on_AgroArea_sheep_detected(sheep_position):
	var sheep_direction = Vector2(sheep_position - position)
	if path_not_blocked(sheep_direction):
		direction = sheep_direction.normalized()

func path_not_blocked(destination):
	ray.cast_to = destination
	if ray.get_collider() != null and !ray.get_collider().is_in_group("obstacles"):
		return true