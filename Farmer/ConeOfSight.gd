extends Area2D

signal farmer_saw_player
signal farmer_lost_player

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var saw_player = false
	var player_pos
	for body in get_overlapping_bodies():
		if (body.get_name() == "Player" and !body.sheep):
			saw_player = true
			player_pos = body.position
			
	if (saw_player):
		emit_signal("farmer_saw_player", player_pos)
	else:
		emit_signal("farmer_lost_player")