extends Node

const RED_ENEMY = preload("res://scenes/enemy_scenes/redEnemy.tscn")
const PURPLE_ENEMY = preload("res://scenes/enemy_scenes/purple_worm.tscn")
const SWIRL_ENEMY = preload("res://scenes/enemy_scenes/swirl_enemy.tscn")
const ZAG_ENEMY = preload("res://scenes/enemy_scenes/zag_enemy.tscn")
const STAR_ENEMY = preload("res://scenes/enemy_scenes/star_enemy.tscn")
const BULK_ENEMY = preload("res://scenes/enemy_scenes/bulk_enemy.tscn")
const BOSS_ENEMY = preload("res://scenes/enemy_scenes/boss_enemy.tscn")
const COUNTER_ENEMY = preload("res://scenes/enemy_scenes/counter_enemy.tscn")

var difficulty: float = 1.0

var randomEnNum: int


var starEn1 = STAR_ENEMY.instantiate()
var starEn2 = STAR_ENEMY.instantiate()
var starEn3 = STAR_ENEMY.instantiate()
var starEn4 = STAR_ENEMY.instantiate()
var starEn5 = STAR_ENEMY.instantiate()
var starEn6 = STAR_ENEMY.instantiate()
var starEn7 = STAR_ENEMY.instantiate()

var onWave: int = 0

var wave_time_1: float = 0.0
var wave_time_2: float = 0.0
var wave_time_3: float = 0.0
var wave_time_4: float = 0.0
var wave_time_5: float = 0.0
var wave_time_6: float = 0.0
var wave_time_7: float = 0.0


var stage1EnArray = []


func _ready():
	if Global.waveNum == 7:
		onWave = 1
	elif Global.waveNum == 5:
		onWave = 2
	elif Global.waveNum == 3:
		onWave = 3

var firstW1: bool = true
var firstW2: bool = true
var firstW3: bool = true
var firstW4: bool = true
var firstW5: bool = true
var firstW6: bool = true
var firstW7: bool = true

var firstSp1: bool = true
var firstSp2: bool = true
var firstSp3: bool = true
var firstSp4: bool = true
var firstSp5: bool = true
var firstSp6: bool = true
var firstSp7: bool = true

func _process(delta):
	
	if Global.current_stage == "Learner Lagoon":
		if onWave == 3 && firstSp3:
			firstSp3 = false
			generalMultiSpawn(50,"red",0.3)
		if onWave == 4 && firstSp4:
			firstSp4 = false
			generalMultiSpawn(5,"swirl",3)
		if onWave == 5 && firstSp5:
			firstSp5 = false
			generalMultiSpawn(20,"red",2)
			generalMultiSpawn2(7,"swirld",3)
	
	if Global.current_stage == "Perfect Pond":
		if onWave == 3 && firstSp3:
			firstSp3 = false
			generalPerfSpawn(15,"purple")
		if onWave == 4 && firstSp4:
			firstSp4 = false
			generalPerfSpawn(10,"swirl")
			generalMultiSpawn(10,"red",2)
		if onWave == 5 && firstSp5:
			firstSp5 = false
			generalMultiSpawn(10,"purple",1.5)
			generalPerfSpawn(20,"zag")
			generalMultiSpawn2(2,"bulk",5)
	
	if Global.current_stage == "Giga Geyser":
		if onWave == 2 && firstSp2:
			firstSp2 = false
			generalMultiSpawn(1,"boss",5)
		if onWave == 3 && firstSp3:
			firstSp3 = false
			generalPerfSpawn(35,"purple")
			generalMultiSpawn(10,"zag",1.5)
		if onWave == 4 && firstSp4:
			firstSp4 = false
			generalPerfSpawn(10,"swirl")
			generalMultiSpawn(10,"red",1.5)
			generalMultiSpawn2(3,"boss",5)
		if onWave == 5 && firstSp5:
			firstSp5 = false
			generalMultiSpawn(10,"zag",1.5)
			generalPerfSpawn(8,"bulk")
		if onWave == 6 && firstSp6:
			firstSp6 = false
			generalPerfSpawn(5,"boss")
			generalMultiSpawn(10,"swirl",1.5)
	
	if Global.current_stage == "Swirly Swamp":
		if onWave == 1 && firstSp1:
			firstSp1 = false
			generalMultiSpawn(1,"counter",5)
		if onWave == 2 && firstSp2:
			firstSp2 = false
			generalMultiSpawn(20,"red",1.5)
			generalMultiSpawn2(3,"boss",5)
		if onWave == 3 && firstSp3:
			firstSp3 = false
			generalPerfSpawn(5,"counter")
			generalMultiSpawn(10,"zag",1.5)
		if onWave == 4 && firstSp4:
			firstSp4 = false
			generalPerfSpawn(3,"bulk")
			generalMultiSpawn2(3,"boss",5)
		if onWave == 5 && firstSp5:
			firstSp5 = false
			generalMultiSpawn(35,"zag",0.5)
			generalPerfSpawn(1,"boss")
		if onWave == 6 && firstSp6:
			firstSp6 = false
			generalPerfSpawn(5,"counter")
			generalMultiSpawn(20,"swirl",0.5)
		if onWave == 7 && firstSp7:
			firstSp7 = false
			generalMultiSpawn(100,"red",0.2)
			generalPerfSpawn(6,"boss")
	
	if onWave == 1:
		wave_time_1 += delta * Global.gameTimeScale
		if wave_time_1 >= Global.wave1Wait:
			wave_time_1 = Global.wave1Wait
			if firstW1:
				wave_timer_1_timeout()
				firstW1 = false
	elif onWave == 2:
		wave_time_2 += delta * Global.gameTimeScale
		if wave_time_2 >= Global.wave2Wait:
			wave_time_2 = Global.wave2Wait
			if firstW2:
				wave_timer_2_timeout()
				firstW2 = false
	elif onWave == 3:
		wave_time_3 += delta * Global.gameTimeScale
		if wave_time_3 >= Global.wave3Wait:
			wave_time_3 = Global.wave3Wait
			if firstW3:
				wave_timer_3_timeout()
				firstW3 = false
	elif onWave == 4:
		wave_time_4 += delta * Global.gameTimeScale
		if wave_time_4 >= Global.wave4Wait:
			wave_time_4 = Global.wave4Wait
			if firstW4:
				wave_timer_4_timeout()
				firstW4 = false
	elif onWave == 5:
		wave_time_5 += delta * Global.gameTimeScale
		if wave_time_5 >= Global.wave5Wait:
			wave_time_5 = Global.wave5Wait
			if firstW5:
				wave_timer_5_timeout()
				firstW5 = false
	elif onWave == 6:
		wave_time_6 += delta * Global.gameTimeScale
		if wave_time_6 >= Global.wave6Wait:
			wave_time_6 = Global.wave6Wait
			if firstW6:
				wave_timer_6_timeout()
				firstW6 = false
	elif onWave == 7:
		wave_time_7 += delta * Global.gameTimeScale
		if wave_time_7 >= Global.wave7Wait:
			wave_time_7 = Global.wave7Wait
			if firstW7:
				wave_timer_7_timeout()
				firstW7 = false
	
	
	
	if onWave == 0 || onWave == 1:
		Global.firstWaveProgress = (wave_time_1 / Global.wave1Wait) * 100
	elif onWave == 2:
		Global.secondWaveProgress = (wave_time_2 / Global.wave2Wait) * 100
	elif onWave == 3:
		Global.thirdWaveProgress = (wave_time_3 / Global.wave3Wait) * 100
	elif onWave == 4:
		Global.fourthWaveProgress = (wave_time_4 / Global.wave4Wait) * 100
	elif onWave == 5:
		Global.fifthWaveProgress = (wave_time_5 / Global.wave5Wait) * 100
	elif onWave == 6:
		Global.sixthWaveProgress = (wave_time_6 / Global.wave6Wait) * 100
	elif onWave == 7:
		Global.seventhWaveProgress = (wave_time_7 / Global.wave7Wait) * 100
	
	if starEn1 == null:
		if onWave == 1:
			Global.firstWaveProgress = 101
			onWave = 2
	elif !starEn1.isAlive:
		if onWave == 1:
			Global.firstWaveProgress = 101
			onWave = 2
	
	if starEn2 == null:
		if onWave == 2:
			Global.secondWaveProgress = 101
			onWave = 3
	elif !starEn2.isAlive:
		if onWave == 2:
			Global.secondWaveProgress = 101
			onWave = 3
	
	if starEn3 == null:
		if onWave == 3:
			Global.thirdWaveProgress = 101
			onWave = 4
	elif !starEn3.isAlive:
		if onWave == 3:
			Global.thirdWaveProgress = 101
			onWave = 4
	
	if starEn4 == null:
		if onWave == 4:
			Global.fourthWaveProgress = 101
			onWave = 5
	elif !starEn4.isAlive:
		if onWave == 4:
			Global.fourthWaveProgress = 101
			onWave = 5
	
	if starEn5 == null:
		if onWave == 5:
			Global.fifthWaveProgress = 101
			onWave = 6
	elif !starEn5.isAlive:
		if onWave == 5:
			Global.fifthWaveProgress = 101
			onWave = 6
	
	if starEn6 == null:
		if onWave == 6:
			Global.sixthWaveProgress = 101
			onWave = 7
	elif !starEn6.isAlive:
		if onWave == 6:
			Global.sixthWaveProgress = 101
			onWave = 7
	
	if starEn7 == null:
		if onWave == 7:
			Global.seventhWaveProgress = 101
			onWave = 8
	elif !starEn7.isAlive:
		if onWave == 7:
			Global.seventhWaveProgress = 101
			onWave = 8



var innerBoundX = 2000
var innerBoundY = 2000
var outerBoundX = 3000
var outerBoundY = 3000

var globRadius: float = 0

var x: float = 0
var y: float = 0

var flipSprite: float = 0

var theta: float = 0.0
var radius: float = 4000
@onready var next_en_timer = $NextEnTimer
var nextEnAmount = 0
var genEnemy = "red"
var nextEnAmount2 = 0
var genEnemy2 = "red"


func _on_next_en_timer_timeout():
	if genEnemy == "red":
		spawnRedEnemy()
	elif genEnemy == "bulk":
		spawnBulkEnemy()
	elif genEnemy == "purple":
		spawnPurpleEnemy()
	elif genEnemy == "swirl":
		spawnSwirlEnemy()
	elif genEnemy == "zag":
		spawnZagEnemy()
	elif genEnemy == "boss":
		spawnBossEnemy()
	elif genEnemy == "counter":
		spawnCounterEnemy()
	
	if nextEnAmount >= 1:
		nextEnAmount -= 1
	else:
		next_en_timer.stop()

func generalMultiSpawn(amount,enemy,delay):
	next_en_timer.wait_time = delay
	nextEnAmount = amount
	genEnemy = enemy
	next_en_timer.start()

@onready var next_en_timer_2 = $NextEnTimer2

func _on_next_en_timer_2_timeout():
	if genEnemy2 == "red":
		spawnRedEnemy()
	elif genEnemy2 == "bulk":
		spawnBulkEnemy()
	elif genEnemy2 == "purple":
		spawnPurpleEnemy()
	elif genEnemy2 == "swirl":
		spawnSwirlEnemy()
	elif genEnemy2 == "zag":
		spawnZagEnemy()
	elif genEnemy2 == "boss":
		spawnBossEnemy()
	elif genEnemy2 == "counter":
		spawnCounterEnemy()
	
	if nextEnAmount2 >= 1:
		nextEnAmount2 -= 1
	else:
		next_en_timer_2.stop()

func generalMultiSpawn2(amount,enemy,delay):
	next_en_timer_2.wait_time = delay
	nextEnAmount2 = amount
	genEnemy2 = enemy
	next_en_timer_2.start()


func generalPerfSpawn(amount,enemy):
	var i = 0
	while i < amount:
		theta = ((2*PI)/amount) * i
		if theta >= PI/2 && theta <= 3 * PI / 2:
			flipSprite = 1
		else:
			flipSprite = -1
		
		if enemy == "red":
			var red = RED_ENEMY.instantiate()
			red.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
			get_parent().add_child.call_deferred(red)
		elif enemy == "bulk":
			var bulk = BULK_ENEMY.instantiate()
			bulk.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
			get_parent().add_child.call_deferred(bulk)
		elif enemy == "purple":
			var purple = PURPLE_ENEMY.instantiate()
			purple.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
			get_parent().add_child.call_deferred(purple)
		elif enemy == "swirl":
			var swirl = SWIRL_ENEMY.instantiate()
			swirl.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
			get_parent().add_child.call_deferred(swirl)
		elif enemy == "zag":
			var zag = ZAG_ENEMY.instantiate()
			zag.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
			get_parent().add_child.call_deferred(zag)
		elif enemy == "boss":
			var boss = BOSS_ENEMY.instantiate()
			boss.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
			get_parent().add_child.call_deferred(boss)
		elif enemy == "counter":
			var counter = COUNTER_ENEMY.instantiate()
			counter.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
			get_parent().add_child.call_deferred(counter)
		
		i += 1



func spawnGeneral(enemy):
	theta = randf_range(0.0, 6.283)
	if theta >= PI/2 && theta <= 3 * PI / 2:
		flipSprite = 1
	else:
		flipSprite = -1
	enemy.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
	get_parent().add_child.call_deferred(enemy)





func spawnRedEnemy():
	var enemy = RED_ENEMY.instantiate()
	spawnGeneral(enemy)

func spawnPurpleEnemy():
	var enemy = PURPLE_ENEMY.instantiate()
	spawnGeneral(enemy)

func spawnSwirlEnemy():
	var enemy = SWIRL_ENEMY.instantiate()
	spawnGeneral(enemy)

func spawnZagEnemy():
	var enemy = ZAG_ENEMY.instantiate()
	spawnGeneral(enemy)

func spawnStarEnemy():
	var enemy = STAR_ENEMY.instantiate()
	spawnGeneral(enemy)

func spawnBulkEnemy():
	var enemy = BULK_ENEMY.instantiate()
	spawnGeneral(enemy)

func spawnBossEnemy():
	var enemy = BOSS_ENEMY.instantiate()
	spawnGeneral(enemy)

func spawnCounterEnemy():
	var enemy = COUNTER_ENEMY.instantiate()
	spawnGeneral(enemy)




func wave_timer_1_timeout():
	theta = randf_range(0.0, 6.283)
	if theta >= PI/2 && theta <= 3 * PI / 2:
		flipSprite = 1
	else:
		flipSprite = -1
	starEn1.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
	get_parent().add_child.call_deferred(starEn1)
	onWave = 1


func wave_timer_2_timeout():
	theta = randf_range(0.0, 6.283)
	if theta >= PI/2 && theta <= 3 * PI / 2:
		flipSprite = 1
	else:
		flipSprite = -1
	starEn2.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
	get_parent().add_child.call_deferred(starEn2)


func wave_timer_3_timeout():
	theta = randf_range(0.0, 6.283)
	if theta >= PI/2 && theta <= 3 * PI / 2:
		flipSprite = 1
	else:
		flipSprite = -1
	starEn3.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
	get_parent().add_child.call_deferred(starEn3)


func wave_timer_4_timeout():
	theta = randf_range(0.0, 6.283)
	if theta >= PI/2 && theta <= 3 * PI / 2:
		flipSprite = 1
	else:
		flipSprite = -1
	starEn4.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
	get_parent().add_child.call_deferred(starEn4)


func wave_timer_5_timeout():
	theta = randf_range(0.0, 6.283)
	if theta >= PI/2 && theta <= 3 * PI / 2:
		flipSprite = 1
	else:
		flipSprite = -1
	starEn5.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
	get_parent().add_child.call_deferred(starEn5)


func wave_timer_6_timeout():
	theta = randf_range(0.0, 6.283)
	if theta >= PI/2 && theta <= 3 * PI / 2:
		flipSprite = 1
	else:
		flipSprite = -1
	starEn6.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
	get_parent().add_child.call_deferred(starEn6)


func wave_timer_7_timeout():
	theta = randf_range(0.0, 6.283)
	if theta >= PI/2 && theta <= 3 * PI / 2:
		flipSprite = 1
	else:
		flipSprite = -1
	starEn7.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
	get_parent().add_child.call_deferred(starEn7)





