extends Panel

@onready var score_display = $"Score Text"

signal restart_button_pressed
signal quit_button_pressed

func _on_restart_button_pressed():
	emit_signal("restart_button_pressed")

func _on_quit_button_pressed():
	emit_signal("quit_button_pressed")
