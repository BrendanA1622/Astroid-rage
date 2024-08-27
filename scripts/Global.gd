extends Node

var explodeShotAmount: int = 8

var explodeBoogers: bool = false

const tarPracS1: int = 1000
const tarPracS2: int = 2000
const tarPracS3: int = 4000
const tarPracS4: int = 10000
const tarPracS5: int = 20000
const tarPracS6: int = 50000
const tarPracS7: int = 100000

const popS1: int = 1000
const popS2: int = 2000
const popS3: int = 4000
const popS4: int = 10000
const popS5: int = 20000
const popS6: int = 30000
const popS7: int = 50000

const ricoS1: int = 1000
const ricoS2: int = 2000
const ricoS3: int = 4000
const ricoS4: int = 10000
const ricoS5: int = 20000
const ricoS6: int = 30000
const ricoS7: int = 50000

const autoS1: int = 1000
const autoS2: int = 2000
const autoS3: int = 4000
const autoS4: int = 10000
const autoS5: int = 20000
const autoS6: int = 30000
const autoS7: int = 50000

var curS1: int = 1
var curS2: int = 2
var curS3: int = 4
var curS4: int = 10
var curS5: int = 20
var curS6: int = 50
var curS7: int = 100

var curStage: int = 0

var gameOver: bool = false

var gameTimeScale: float = 1.0

var highscore: int = 0
var popHighscore: int = 0
var ricoHighscore: int = 0
var autoHighscore: int = 0
var gameHighscore: int = 0

var curHighscore: int = 0

var points: int = 0
var consecBulls: int = 0

var evoLevel: int = 2

var mutateNumber: int = 1
var barrelUpNumArray: Array = [1,0,0,0,0,0,0,0]
var evolutionPoints: int = 10

var squareWaitTime = 3.1
var healthWaitTime = 12.0
var xpNodesOnScreen = 0
var level = 1

var enemyNum = 0

var bulletSize = 2
var bulletSpeed: float = 2.0
var damage = 4
var rotationSpeed: float = 3.0

var totalPoints = 30
var unspentPoints = 30

var xpAmount = 0.0

var player_health = 100.0

var popup_shouldbe_visible: bool = true

var difficulty: float = 1.0
var wave_progress: float = 100.0
var prior_dir: float = 1.0

var firstEvolveCheck: bool = true

var startCrasher: bool = false
var crashStarted: bool = false
var impactSequence: bool = false
var softCam: bool = false

func addXP(num):
	xpAmount += num * difficulty
	if xpAmount >= 6.28:
		xpAmount = xpAmount - 6.28
		level += 1
		unspentPoints += 1
		popup_shouldbe_visible = true
		difficulty -= difficulty * 0.1
		if level % evoLevel == 0 && firstEvolveCheck == true:
			Global.evolutionPoints += 1
			firstEvolveCheck = false
		if level % evoLevel == 1:
			firstEvolveCheck = true

func resetStats():
	bulletSize = 2
	bulletSpeed = 2
	damage = 4
	rotationSpeed = 3.0
	level = 1
	xpAmount = 0.0
	player_health = 100.0
	difficulty = 1.0
	xpNodesOnScreen = 0
	enemyNum = 0
	totalPoints = 0
	unspentPoints = 0
	popup_shouldbe_visible = false
	mutateNumber = 1
	evolutionPoints = 0
	barrelUpNumArray = [1,0,0,0,0,0,0,0]
	
	if curStage == -1:
		if points > highscore:
			gameHighscore = points
			print("changed highscore")
	
	if curStage == 1:
		if points > highscore:
			highscore = points
	if curStage == 2:
		if points > popHighscore:
			popHighscore = points
	if curStage == 3:
		if points > ricoHighscore:
			ricoHighscore = points
	if curStage == 4:
		if points > autoHighscore:
			autoHighscore = points
	
	points = 0
	consecBulls = 0
	explodeBoogers = false

func decreaseHealth(num):
	player_health -= num * 31.0

func decreaseEnemyNum():
	enemyNum -= 1
	wave_progress -= 5.0
