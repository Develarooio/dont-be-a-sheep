extends KinematicBody2D

var can_shoot = true
var can_update_face_direction = true
var bullet_scene = preload("res://Bullet/Bullet.tscn")
var can_see_player = false
var last_frame_pos
var facing_direction

var sight_color = Color(1.0,0,0)

var ray_hits = []

func _ready():
	last_frame_pos = global_position
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	update()
	
	if can_update_face_direction:
		facing_direction =  last_frame_pos - global_position
		last_frame_pos = global_position
		can_update_face_direction = false
		$FaceTimer.start()
		
	
	if !can_see_player:
		face(facing_direction)
	
	can_see_player = false
	ray_hits = []
	for body in $ConeOfSight.get_overlapping_bodies():
		if (body.get_name() == "Player" and
			!body.sheep and
			has_los_with_player_body(body)):
			can_see_player = true
			if (can_shoot):
				shoot_at(body.get_global_position())

func draw_sight(cast_result):
	draw_line(Vector2(), (cast_result.position - global_position), sight_color)

func face(direction):
	$ConeOfSight.set_rotation(direction.angle() + (PI/2))

func _draw():
	for hit in ray_hits:
		draw_sight(hit)

func has_los_with_player_body(body):
	# Cast some rays to see if there are obstacles between the player
	# and the farmer
	var space_state = get_world_2d().direct_space_state
	var extents = body.get_shape().extents
	var body_pos = body.get_global_position()
	
	var nw_corner = body_pos - extents
	var sw_corner = Vector2((body_pos.x - extents.x), (body_pos.y + extents.y))
	var ne_corner = Vector2((body_pos.x + extents.x), (body_pos.y - extents.y))
	var se_corner = body_pos + extents

	for pos in [body_pos, nw_corner, sw_corner, ne_corner, se_corner]:
		var ray_res = space_state.intersect_ray(global_position, pos, [self], 1)
		if ray_res and ray_res.collider.get_name() == "Player":
			ray_hits.append(ray_res)

	if ray_hits.size() > 0:
		return true
	else:
		return false
	
	return false
	

func shoot_at(player_pos):
	var bullet = bullet_scene.instance()
	bullet.set_direction((player_pos - global_position).normalized())
	bullet.position = get_global_position()
	get_node("/root").add_child(bullet)
	can_shoot = false
	$ShootTimer.start()

func _on_ShootTimer_timeout():
	can_shoot = true # replace with function body

func _on_FaceTimer_timeout():
	can_update_face_direction = true # replace with function body
