extends KinematicBody2D

var can_shoot = true
var bullet_scene = preload("res://Bullet/Bullet.tscn")
# Not sure if this does anything
var can_see_player = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _on_ConeOfSight_farmer_saw_player(body):
	can_see_player = true
	if (can_shoot) and has_los_with_player_body(body):
		shoot_at(body.get_global_position())

func has_los_with_player_body(body):
	# Cast some rays to see if there are obstacles between the player
	# and the farmer
	var space_state = get_world_2d().direct_space_state
	var extents = body.get_shape().extents
	var body_pos = body.get_global_position()
	
	var sw_corner = Vector2((body_pos.x - extents.x), (body_pos.y + extents.y))
	var ne_corner = Vector2((body_pos.x - extents.x), (body_pos.y + extents.y))
	

func shoot_at(player_pos):
	var bullet = bullet_scene.instance()
	print(player_pos)
	print(get_global_position())
	bullet.set_direction((player_pos - global_position).normalized())
	bullet.position = get_global_position() - Vector2(0,80)
	get_node("/root").add_child(bullet)
	can_shoot = false
	$ShootTimer.start()


func _on_ShootTimer_timeout():
	can_shoot = true # replace with function body


func _on_ConeOfSight_farmer_lost_player():
	can_see_player = false
