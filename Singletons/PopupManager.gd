extends Node

@onready var popup_layer = %PopupLayer

func trigger_virus_popup(name : String):
	var popup = preload("res://Scenes/popup_window.tscn").instantiate()
	popup.set_text("⚠️\n" + name + " triggered a virus.\nClose all pop-ups to resume.")
	popup_layer.add_child(popup)
