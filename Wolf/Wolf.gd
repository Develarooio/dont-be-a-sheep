extends KinematicBody2D

var direction = Vector2(0,0)
var rand_directionr = Vector2(0,0)
var default_speed = 400
onready  var ray0 = get_node("Ray0")
onready  var ray1 = get_node("Ray1")
onready  var ray2 = get_node("Ray2")
onready  var ray3 = get_node("Ray3")
onready var change_timer = get_node("ChangeDirection")
onready var direction_pause_timer = get_node("DirectionPause")
var wolf_paused = false
var wolf_traveling = true

var rays = []
var sheep_detected = false
var patrol_speed = 50

var previous_position

func _ready():
	previous_position = position
	randomize()
	direction = calc_random_direction()
	rays = [ray0, ray1, ray2, ray3]

func _process(delta):
	var current_direction = position - previous_position
	if current_direction.x > 0:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.playing = true
	elif current_direction.x < 0:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.playing = true
	elif current_direction.x == 0 and current_direction.y == 0:
		$AnimatedSprite.stop()
	var speed = default_speed
	if !sheep_detected:
		speed = patrol_speed
		if wolf_paused:
			direction = Vector2(0,0)
		elif !wolf_paused and change_timer.is_stopped():
			change_timer.start()
	
	previous_position = position

	move_and_slide(direction*speed)

func _on_AgroArea_sheep_detected(player_body):
	sheep_detected = false
	var sheep_direction = Vector2(player_body.get_position() - position)
	var rect_coord = get_corners_from_extents(player_body.get_shape().extents)
	if !path_blocked(sheep_direction, rect_coord):
		sheep_detected = true
		direction = sheep_direction.normalized()

func path_blocked(sheep_center, rect_coords):
	var blocked = []
	for i in range(0, rect_coords.size()):
		rays[i].cast_to = sheep_center + rect_coords[i]
		if rays[i].get_collider() != null and rays[i].get_collider().is_in_group("obstacles"):
			blocked.append(true)
		elif rays[i].get_collider() != null and rays[i].get_collider().is_in_group("sheep"):
			blocked.append(false)
	if blocked.has(false):
		return false
	else:
		return true

func get_corners_from_extents(half_extents):
	var result = []
	result.append(Vector2(half_extents[0] *-1, half_extents[1]))
	result.append(Vector2(half_extents[0], half_extents[1]*-1))
	result.append(Vector2(half_extents[0]*-1, half_extents[1]*-1))
	result.append(Vector2(half_extents[0], half_extents[1]))
	return result

func _on_KillZone_body_entered(body):
	if body.is_in_group("sheep"):
		body.kill()
		
func calc_random_direction():
	var result = Vector2(randf(), randf())
	if randi() % 2 > 0:
		result.x *= -1
	elif randi() % 2 > 0:
		result.y *= -1
	return result.normalized()

func _on_ChangeDirection_timeout():
	wolf_paused = true
	direction_pause_timer.start()
	
func _on_DirectionPause_timeout():
	wolf_paused = false
	direction = calc_random_direction()
