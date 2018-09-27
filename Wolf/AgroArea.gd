extends Area2D

signal sheep_detected

func _process(delta):
	for body in get_overlapping_bodies():
		if body.get_name() == "Player":
			if body.sheep:
				emit_signal("sheep_detected", body.position)
