extends Control

signal close_requested


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Connect Close button signal to close the app
	%CloseBtn.pressed.connect(_on_close_pressed)
	
	# Dynamically connect resolution buttons
	for child in %VBoxContainer.get_children():
		if child is Button:
			child.pressed.connect(_on_resolution_pressed.bind(child.text))
	

func _on_close_pressed():
	emit_signal("close_requested")


func _on_resolution_pressed(label: String) -> void:
	if SettingsManager.resolutions.has(label):
		set_resolution(SettingsManager.resolutions[label])

func set_resolution(resolution: Vector2) -> void:
	DisplayServer.window_set_size(resolution)
	center_window()
	

func center_window() -> void:
	var screen := DisplayServer.get_display_safe_area() # gets screen dimensions
	var window_size := DisplayServer.window_get_size() # get window size
	var centered_pos := (screen.size - window_size) / 2 + screen.position
	DisplayServer.window_set_position(centered_pos)
