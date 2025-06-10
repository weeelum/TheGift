extends Control

signal close_requested

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Connect Close button signal to close the app
	%CloseBtn.pressed.connect(_on_close_pressed)
	

func _on_close_pressed():
	emit_signal("close_requested")
	print("Close button pressed")
