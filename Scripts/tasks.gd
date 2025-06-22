extends Control

signal close_requested

var tasks : Dictionary = {}
var active_tasks : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%CloseBtn.pressed.connect(_on_close_pressed)
	
	GameManager.load_tasks()
	

func _on_close_pressed():
	emit_signal("close_requested")
