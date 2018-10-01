extends Area2D

# This signal is a bit misnamed - it's actually that the player entered the farmer's
# cone of sight, the farmer is the one who will see if he can see the player
signal farmer_saw_player
signal farmer_lost_player

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	var saw_player = false
	var player_body
	
	for body in get_overlapping_bodies():
		if (body.get_name() == "Player" and !body.sheep):
			saw_player = true
			player_body = body
			
	if (saw_player):
		emit_signal("farmer_saw_player", player_body)
	else:
		emit_signal("farmer_lost_player")