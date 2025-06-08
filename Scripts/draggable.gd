extends Control

var dragging := false
var drag_offset := Vector2.ZERO

func _input(event : InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if %Messages.get_global_rect().has_point(get_viewport().get_mouse_position()):
					dragging = true
					drag_offset = get_viewport().get_mouse_position() - %Messages.global_position
			else:
				dragging = false

func _process(_delta: float) -> void:
	if dragging:
		var mouse_pos = get_viewport().get_mouse_position()
		%Messages.global_position = mouse_pos - drag_offset
