extends HBoxContainer

signal popup_triggered

var time_remaining : float = 0.0
var track_data : Dictionary
var popup_manager : CanvasLayer


func _ready() -> void:
	pass

func setup(data : Dictionary, popup : CanvasLayer):
	track_data = data
	popup_manager = popup
	time_remaining = float(data["time"])
	
	%Name.text = data["name"]
	%Progress.value = 0.0
	%Progress.max_value = time_remaining
	

func advance(delta : float) -> bool:
	time_remaining -= delta
	%Progress.value = %Progress.max_value - time_remaining
	
	if time_remaining <= 0:
		if track_data.get("risk", "") == "Virus":
			PopupManager.trigger_virus_popup(track_data["name"])
			print("")
		return true # Done downloading
	return false
	

func _on_popup_triggered() -> void:
	emit_signal("popup_triggered")
