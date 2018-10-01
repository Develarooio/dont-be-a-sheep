extends KinematicBody2D

var direction = Vector2(0,0)
var speed = 400
onready  var ray = get_node("Ray")

func _process(delta):
	move_and_slide(direction * speed)
	direction = Vector2(0,0)

func _on_AgroArea_sheep_detected(player_body):
	var sheep_direction = Vector2(player_body.position - position)
	var rect_coord = get_corners_from_extents(player_body.shape_owner_get_shape(0,0).extents)
	if path_blocked(sheep_direction, rect_coord):
		direction = sheep_direction.normalized()

func path_blocked(sheep_center, rect_coords):
	var blocked = false
	ray.cast_to = sheep_center
	#print("=======================================")
	#for coord in rect_coords:
	#	print(coord + sheep_center)
	#	ray.cast_to = sheep_center + coord
	#	if ray.get_collider() != null and !ray.get_collider().is_in_group("obstacles"):
	#		blocked = true
	return false

func get_corners_from_extents(half_extents):
	var result = []
	result.append(Vector2(half_extents[0] *-1, half_extents[1]))
	result.append(Vector2(half_extents[0], half_extents[1]*-1))
	result.append(Vector2(half_extents[0]*-1, half_extents[1]*-1))
	result.append(Vector2(half_extents[0], half_extents[1]))
	return result