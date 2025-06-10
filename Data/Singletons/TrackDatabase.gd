extends Node

var tracks = []

func _ready() -> void:
	load_tracks()
	

func load_tracks():
	var file = FileAccess.open("res://Data/tracks.json", FileAccess.READ)
	tracks = JSON.parse_string(file.get_as_text())
