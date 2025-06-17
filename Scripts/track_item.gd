extends HBoxContainer

signal track_toggled(data : Dictionary)

var song_data : Dictionary

# Set UI track data ★☆
func set_track_data(data : Dictionary):
	song_data = data
	%Name.text = data["name"]
	%Size.text = data["size"]
	$Length.text = data["length"]
	%BPM.text = str(data.get("bpm", "-"))
	%Tags.text = ", ".join(data.get("tags", []))
	%Rating.text = str(data["rating"])


func _on_select_btn_pressed() -> void:
	pass


func _on_select_btn_toggled(toggled_on: bool) -> void:
	if toggled_on:
		emit_signal("track_toggled", song_data)
		print("'%s' selected" % song_data["name"])
	else:
		return
