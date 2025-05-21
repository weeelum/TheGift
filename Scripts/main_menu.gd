extends Control

var quiz_game : Node2D = preload("res://Scenes/qg.tscn").instantiate()


func _on_qg_button_pressed() -> void:
	add_child(quiz_game)
