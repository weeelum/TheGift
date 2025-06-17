extends PopupPanel

#func center_popup() -> void:
	#var screen := DisplayServer.get_display_safe_area() # gets screen dimensions
	#var window_size := DisplayServer.window_get_size() # get window size
	#var centered_pos := (screen.size - window_size) / 2 + screen.position
	#DisplayServer.window_set_position(centered_pos)

func set_text(msg : String):
	%Label.text = msg


func _on_CloseBtn_pressed():
	queue_free()
