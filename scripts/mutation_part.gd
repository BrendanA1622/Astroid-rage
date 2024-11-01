extends Node2D
@onready var tank_bird_nose = $SnoutPosition/TankBirdNose
@onready var bird_eyelid = $BirdEyelid
@onready var tank_bird_pupil = $TankBirdPupil
@onready var snout_position = $SnoutPosition
@onready var cpu_particles_2d = $SnoutPosition/CPUParticles2D

func changeBarrelUpgrade(num):
	if num == 2:
		tank_bird_nose.texture = preload("res://assets/tankBird/barrelUpgrade2(first).png")
	elif num == 3:
		tank_bird_nose.texture = preload("res://assets/tankBird/barrelUpgrade3.png")
	elif num == 4:
		tank_bird_nose.texture = preload("res://assets/tankBird/barrelUpgrade4.png")
	elif num == 5:
		tank_bird_nose.texture = preload("res://assets/tankBird/barrelUpgrade5.png")

func noseScale():
	return tank_bird_nose.scale.x

func scaleNose(num):
	tank_bird_nose.scale.x = num

func scaleEyelid(num):
	bird_eyelid.scale.x = num

func scalePupil(num):
	tank_bird_pupil.scale.x = num
	tank_bird_pupil.scale.y = num

func snoutPositionX():
	return snout_position.global_position.x

func snoutPositionY():
	return snout_position.global_position.y



func setFire(val):
	if val > 0:
		cpu_particles_2d.color = Color8(100 + val*20,100 - val*20,100 - val*20,255)
		
		cpu_particles_2d.emitting = true
	else:
		cpu_particles_2d.emitting = false
	
