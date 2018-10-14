extends Area2D

var direction
var speed = 10

func _ready():
	$AnimationPlayer.play("bullet")
	pass
	
func set_direction(dir):
	direction = dir
	
func _physics_process(delta):
	for body in get_overlapping_bodies():
		print(body.get_name())
		if body.get_name() == "Player":
			body.kill()
			queue_free()
		elif !body.get_name() == "Farmer":
			queue_free()
			
			

	position = position + (direction * speed)
	
