extends PopupPanel

func set_text(msg : String):
	%Label.text = msg


func _on_CloseBtn_pressed():
	queue_free()
