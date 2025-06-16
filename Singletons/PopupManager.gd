extends Node

#var popup_layer : CanvasLayer
#
#func _ready() -> void:
	#popup_layer = get_tree().root.get_node("MainMenu/PopupLayer")

func trigger_virus_popup(name : String):
	var popup = preload("res://Scenes/popup_window.tscn").instantiate()
	popup.set_text("⚠️\n" + name + " triggered a virus.\nClose all pop-ups to resume.")
	add_child(popup)
