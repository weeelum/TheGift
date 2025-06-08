"""Handle desktop logic and inputs"""
extends Node2D

func _ready() -> void:
	DisplayServer.window_set_size(Vector2(2560, 1440))
	center_window()
	

func center_window() -> void:
	var screen := DisplayServer.get_display_safe_area() # gets screen dimensions
	var window_size := DisplayServer.window_get_size() # get window size
	var centered_pos := (screen.size - window_size) / 2 + screen.position
	DisplayServer.window_set_position(centered_pos)
