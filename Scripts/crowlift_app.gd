extends Control

signal close_requested

@onready var track_list = %TrackDataList
@onready var search_bar = %SearchBar
@onready var progress_area = %ProgressArea

var tracks : Array = []
var download_queue : Array = []
var selected_track : Dictionary = {}
var popup_window : CanvasLayer

func _ready() -> void:
	%CloseBtn.pressed.connect(_on_close_pressed)
	
	load_tracks()
	populate_track_list(tracks)


func load_tracks():
	var file = FileAccess.open("res://Data/tracks.json", FileAccess.READ)
	tracks = JSON.parse_string(file.get_as_text())


func _on_SearchBtn_pressed():
	var query = search_bar.text.strip_edges().to_lower()
	var filtered = tracks.filter(func(t): return query in t["name"].to_lower())
	populate_track_list(filtered)

func populate_track_list(data : Array):
	for child in track_list.get_children():
		child.queue_free()
	
	for entry in data:
		var item = preload("res://Scenes/track_item.tscn").instantiate()
		item.set_track_data(entry)
		item.connect("track_toggled", Callable(self, "_on_track_toggled"))
		track_list.add_child(item)
		

func _on_track_toggled(track_data : Dictionary):	
	selected_track = track_data
	

func _on_download_btn_pressed() -> void:
	var row = preload("res://Scenes/progress_row.tscn").instantiate()
	
	if selected_track:		
		row.setup(selected_track, popup_window)
		progress_area.add_child(row)
		download_queue.append(row)
	elif !selected_track:
		return


func _process(delta: float):
	for row in download_queue:
		if row.advance(delta):
			download_queue.erase(row)
			row.queue_free()

func _on_close_pressed():
	emit_signal("close_requested")
