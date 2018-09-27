extends KinematicBody2D

var direction = Vector2(0,0)
var speed = 400
onready var agro = get_node("AgroArea")

func _ready():
	agro.connect("sheep_detected" , self , "update_sheep_coord")

func _process(delta):
	move_and_slide(direction * speed)
	direction = Vector2(0,0)

func update_sheep_coord(sheep_position):
	direction = Vector2(sheep_position - position).normalized()