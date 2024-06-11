extends Area2D

const XP_NOTIFICATION = preload("res://scenes/xp_notification.tscn")

@onready var cpu_particles_2d = $CPUParticles2D
@onready var collision_polygon_2d = $CollisionPolygon2D
@onready var timer = $Timer

var shader_value = material.get_shader_parameter("value")
var shader_alpha = material.get_shader_parameter("alpha")
var damage_chunk = Global.damage * 0.05

var x = 5000
var y = 5000
var hypotenuse
var theta

const SPEED = 300
const FADE_SPEED = 0.5

var innerBoundX = 5000 + 1000 * difficulty
var innerBoundY = 5000 + 1000 * difficulty
var outerBoundX = 6000 + 1000 * difficulty
var outerBoundY = 6000 + 1000 * difficulty

var time_ellapsed = 0

var flipSprite: int = 1

var enemyIndex = 0

var xpAmount: float
var sizeOfEnemy: float

var difficulty: float = 1.0
@onready var zig_zag_enemy = $ZigZagEnemy
var randEnSprite: int

func _ready():
	randEnSprite = randi_range(0,100)
	zig_zag_enemy.texture = preload("res://assets/ZagEnemy/ZigZagEnemy.png")
	
	cpu_particles_2d.scale_amount_min = 30.0 * sizeOfEnemy
	cpu_particles_2d.scale_amount_max = 45.0 * sizeOfEnemy
	cpu_particles_2d.amount = sizeOfEnemy * 3 + 10
	
	innerBoundX = 5000 + 1000 * difficulty
	innerBoundY = 5000 + 1000 * difficulty
	outerBoundX = 6000 + 1000 * difficulty
	outerBoundY = 6000 + 1000 * difficulty

func spawn(dif):
	difficulty = dif
	Global.enemyNum += 1
	enemyIndex = Global.enemyNum
	
	sizeOfEnemy = randf_range(0.5 * difficulty,1.5 * difficulty)
	xpAmount = sizeOfEnemy + pow(sizeOfEnemy,2.0)
	if sizeOfEnemy >= 1.48 * difficulty:
		sizeOfEnemy = 3.0 * difficulty
	scale.x = sizeOfEnemy
	scale.y = sizeOfEnemy
	damage_chunk = Global.damage / (pow(sizeOfEnemy,2) * 10) 
	
	shader_alpha = 0.0
	
	material.set_shader_parameter("alpha_value",shader_alpha)
	
	randomize()
	shader_value = 0.0
	
	x = randf_range(0,outerBoundX)
	if x < innerBoundX:
		y = randf_range(innerBoundY,outerBoundY)
	else:
		y = randf_range(0,outerBoundY)
	if randi_range(0,1) == 1:
		x = -x
	else:
		flipSprite = -1
	if randi_range(0,1) == 1:
		y = -y
	
	hypotenuse = sqrt((x * x) + (y * y))
	
	if y < 0:
		theta = acos(x / hypotenuse)
	else:
		theta = 2 * PI -  acos(x / hypotenuse)
	
	rotation = -theta - PI/2

var randJump: float = randf_range(0.5,4.0)
var randTime: float = randf_range(0.1,1)
var randZag: float = randf_range(-PI/2,PI/2)
var summedTime: float = 0.0

var startingFree: bool = false

func _physics_process(delta):
	
	hypotenuse = sqrt((x * x) + (y * y))
	
	if y < 0:
		theta = acos(x / hypotenuse)
	else:
		theta = 2 * PI -  acos(x / hypotenuse)
	if rotation < (-theta - PI/2 - randZag) - PI/16:
		rotation += delta * 5.0
	elif rotation >= -theta - PI/2 - randZag + PI/16:
		rotation -= delta * 5.0
	
	summedTime += delta
	if summedTime >= randTime:
		var rand_i = randi_range(0,4)
		if rand_i == 0 && !startingFree:
			zig_zag_enemy.texture = preload("res://assets/ZagEnemy/ZigZagEnemy.png")
		elif rand_i == 1 && !startingFree:
			zig_zag_enemy.texture = preload("res://assets/ZagEnemy/ZigZagEnemy (1).png")
		elif rand_i == 2 && !startingFree:
			zig_zag_enemy.texture = preload("res://assets/ZagEnemy/ZigZagEnemy (2).png")
		elif rand_i == 3 && !startingFree:
			zig_zag_enemy.texture = preload("res://assets/ZagEnemy/ZigZagEnemy (3).png")
		elif rand_i == 4 && !startingFree:
			zig_zag_enemy.texture = preload("res://assets/ZagEnemy/ZigZagEnemy (4).png")
		
		randJump = randf_range(0.5,2.0)
		randTime = randf_range(0.1,1)
		randZag = randf_range(-PI/2,PI/2)
		summedTime = 0.0
	else:
		x -= (cos(theta + randZag) * SPEED * delta) * randJump
		y -= (-sin(theta + randZag) * SPEED * delta) * randJump
	
	
	
	position = Vector2(x,y)
	time_ellapsed += delta * 5
	if shader_alpha != 1.0:
		shader_alpha += FADE_SPEED * delta
		shader_alpha = clamp(shader_alpha,0.0,1.0)
		material.set_shader_parameter("alpha_value",shader_alpha)
	

func addDamage():
	shader_value = shader_value + damage_chunk
	
	shader_value = clamp(shader_value,0.0,1.0)
	
	material.set_shader_parameter("damage_value",shader_value)
	
	if shader_value >= 0.9:
		Global.decreaseEnemyNum()
		Global.addXP(xpAmount)
		var xpNotif = XP_NOTIFICATION.instantiate()
		xpNotif.position = Vector2 (x,y)
		xpNotif.getXPSize(xpAmount)
		get_parent().add_child.call_deferred(xpNotif)
		setFreeSequence()

func _on_area_entered(area):
	if area.is_in_group("BoogerArea"):
		area.setFreeSequence()
		addDamage()
	 
	if area.is_in_group("Player"):
		Global.decreaseHealth(sizeOfEnemy - (sizeOfEnemy * shader_value))
		Global.enemyNum -= 1
		setFreeSequence()

func setFreeSequence():
	startingFree = true
	cpu_particles_2d.emitting = true
	zig_zag_enemy.free()
	collision_polygon_2d.free()
	timer.start()

func _on_timer_timeout():
	queue_free()