extends Control

@onready var date_label : Label = %Date
@onready var time_label : Label = %Time

var quiz_game : Node2D = preload("res://Scenes/qg.tscn").instantiate()
var message_app : Control = preload("res://Scenes/message_app.tscn").instantiate()


func _ready() -> void:
	TimeManager.time_updated.connect(_on_time_updated)
	TimeManager.date_updated.connect(_on_date_updated)
	message_app.close_requested.connect(_on_close_message_app)
	
	# Set initial values
	_on_date_updated(TimeManager.get_date_string())
	_on_time_updated(TimeManager.get_time_string())
	
	
func _on_date_updated(new_date: String) -> void:
	date_label.text = new_date
	
	
func _on_time_updated(new_time: String) -> void:
	time_label.text = new_time


func _on_qg_button_pressed() -> void:
	add_child(quiz_game)


func _on_messages_pressed() -> void:
	add_child(message_app)
	message_app.set_position(Vector2(510, 190))


func _on_close_message_app() -> void:
	remove_child(message_app)
