extends KinematicBody2D

var direction = Vector2(0,0)
var speed = 400
onready  var ray0 = get_node("Ray0")
onready  var ray1 = get_node("Ray1")
onready  var ray2 = get_node("Ray2")
onready  var ray3 = get_node("Ray3")
var rays = []

func _ready():
	rays = [ray0, ray1, ray2, ray3]

func _process(delta):
	move_and_slide(direction * speed)
	direction = Vector2(0,0)

func _on_AgroArea_sheep_detected(player_body):
	var sheep_direction = Vector2(player_body.get_position() - position)
	var rect_coord = get_corners_from_extents(player_body.get_shape().extents)
	if !path_blocked(sheep_direction, rect_coord):
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
