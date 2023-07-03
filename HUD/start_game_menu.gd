extends Panel

signal start_button_pressed
signal quit_button_pressed


func _on_start_game_button_pressed():
	emit_signal("start_button_pressed")

func _on_quit_button_pressed():
	emit_signal("quit_button_pressed")
