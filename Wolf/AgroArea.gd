extends Area2D


func _process(delta):
	for body in get_overlapping_bodies():
		print(body.is_in_group("sheep"))