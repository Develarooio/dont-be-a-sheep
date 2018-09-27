extends KinematicBody2D

var can_shoot = true
var bullet_scene = preload("res://Bullet/Bullet.tscn")
var can_see_player = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _on_ConeOfSight_farmer_saw_player(position):
	can_see_player = true
	if (can_shoot):
		shoot_at(position)

func shoot_at(player_pos):
	var bullet = bullet_scene.instance()
	print(player_pos)
	print(position)
	bullet.set_direction((player_pos - global_position).normalized())
	bullet.position = position + Vector2(0,80)
	add_child(bullet)
	can_shoot = false
	$ShootTimer.start()


func _on_ShootTimer_timeout():
	can_shoot = true # replace with function body


func _on_ConeOfSight_farmer_lost_player():
	can_see_player = false
