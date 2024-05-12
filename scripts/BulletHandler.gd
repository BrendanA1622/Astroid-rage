extends Node

const GREEN_SPOT = preload("res://scenes/booger_area.tscn")

@onready var snout_position = $"../BirdBod/SnoutPosition"

var x = 0
var y = 0

var theta = 0

func shoot():
	var greenspot = GREEN_SPOT.instantiate()
	
	get_parent().add_child.call_deferred(greenspot)
	x = snout_position.global_position.x
	y = snout_position.global_position.y
	
	if y < 0:
		theta = acos(x / 300)
	else:
		theta = 2 * PI -  acos(x / 300)
	
	greenspot.set_motion(x,y,theta)
	
	#greenspot.position = Vector2(x,y)
	#greenspot.linear_velocity = Vector2(cos(theta) * SPEED,-sin(theta) * SPEED)
	

func _process(_delta):
	if Input.is_action_just_pressed("switch"):
		shoot()
