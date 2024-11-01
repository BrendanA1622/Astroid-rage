extends CanvasLayer
@onready var game_level_label = $PlayButton/GameLevelLabel

func _ready():
	game_level_label.text = "Level: " + str(Global.gameHighscore) + " PTS"

func _on_play_button_pressed():
	Global.resetStats()
	get_tree().change_scene_to_file("res://scenes/playable_scenes/stage_select.tscn")


func _on_store_page_button_pressed():
	get_tree().change_scene_to_file("res://scenes/playable_scenes/store_page.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_minigame_select_pressed():
	Global.resetStats()
	get_tree().change_scene_to_file("res://scenes/playable_scenes/minigame_select.tscn")

