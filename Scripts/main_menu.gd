#main_menu.gd
extends Control

@onready var date_label : Label = %Date
@onready var time_label : Label = %Time

var quiz_game : Node2D = preload("res://Scenes/qg.tscn").instantiate()
var message_app : Control = preload("res://Scenes/message_app.tscn").instantiate()
var vbay_app : Control = preload("res://Scenes/vbay_app.tscn").instantiate()
var settings_app : Control = preload("res://Scenes/settings_app.tscn").instantiate()

func _ready() -> void:
	TM.time_updated.connect(_on_time_updated)
	TM.date_updated.connect(_on_date_updated)
	
	message_app.close_requested.connect(_on_close_message_app)
	vbay_app.close_requested.connect(_on_close_v_bay_app)
	settings_app.close_requested.connect(_on_close_settings_app)
	
	# Set initial values
	_on_date_updated(TM.get_date_string())
	_on_time_updated(TM.get_time_string())


#func _update_game_state_from_save() -> void:
	#if message_app:
		#message_app.load_state()
		#message_app.thread_display.clear()
		#message_app.thread_display.append_text(
			#message_app.displayed_thread.get(message_app.current_contact, "")
		#)
	
	
func _on_date_updated(new_date: String) -> void:
	date_label.text = new_date
	
	
func _on_time_updated(new_time: String) -> void:
	time_label.text = new_time


#func _on_new_game_btn_pressed() -> void:
	#SM.new_game()
	#_update_game_state_from_save()
	#
#
#func _on_save_btn_pressed() -> void:
	#SM.save_game()
	#
	#
#func _on_load_game_btn_pressed() -> void:
	#SM.load_game()
	#_update_game_state_from_save()

func _on_qg_button_pressed() -> void:
	add_child(quiz_game)


func _on_settings_btn_pressed() -> void:
	add_child(settings_app)
	settings_app.set_position(Vector2(510, 190))
	print("settings app opened")
	

func _on_close_settings_app() -> void:
	remove_child(settings_app)


func _on_messages_pressed() -> void:
	add_child(message_app)
	message_app.set_position(Vector2(510, 190))


func _on_close_message_app() -> void:
	remove_child(message_app)


func _on_v_bay_pressed() -> void:
	add_child(vbay_app)
	vbay_app.set_position(Vector2(510, 190))

func _on_close_v_bay_app() -> void:
	remove_child(vbay_app)
