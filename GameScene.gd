extends Node2D

#Hud Stuff
@onready var start_game_menu = $"Start Game Menu"
@onready var score_display = $"Score Display"
@onready var game_over_menu = $"Game Over Menu"
@onready var game_over_score_display = $"Game Over Menu".get_node("Score Text")
@onready var game_over_high_score_display = $"Game Over Menu".get_node("Highest Score Text")

func _ready():
	start_and_restart_game_calls(start_game_menu, false, 0.0, false)
	Singleton.score = 0
	
	load_save_data()

func _process(_delta):
	score_display.text = str(Singleton.score)


#Buttons
func _on_start_game_menu_start_button_pressed():
	start_and_restart_game_calls(start_game_menu, true, 1.0, true)

func _on_start_game_menu_quit_button_pressed():
	get_tree().quit()

func _on_player_game_over():
	start_and_restart_game_calls(game_over_menu, false, 0.0, false)
	
	score_display.hide()
	game_over_score_display.text = "Score : " + str(Singleton.score)
	
	if Singleton.score >= Singleton.high_score:
		Singleton.high_score = Singleton.score
	
	game_over_high_score_display.text = "High Score : " + str(Singleton.high_score)
	save_save_data()

func _on_game_over_menu_quit_button_pressed():
	get_tree().quit()

func _on_game_over_menu_restart_button_pressed():
	Engine.set_time_scale(1.0)
	get_tree().reload_current_scene()

func start_and_restart_game_calls(hud_element_name, hide_bool, time_scale_value: float,
 player_input_bool: bool):
	hud_element_name.show()
	if hide_bool:
		hud_element_name.hide()
	
	Engine.set_time_scale(time_scale_value)
	Singleton.player_input_enabled = player_input_bool


#Saving
func save_save_data():
	var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	save_file.store_32(Singleton.high_score)

func load_save_data():
	var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	if not save_file == null:
		Singleton.high_score = save_file.get_32()
	else:
		Singleton.high_score = 0
		save_save_data()
