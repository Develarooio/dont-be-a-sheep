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
	pass