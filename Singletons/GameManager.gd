extends Node

enum TaskStatus { NOT_STARTED, ACTIVE, COMPLETE, FAILED }
enum ObjectiveType { DOWNLOAD, BUY, TALK, SORT }

var tasks : Dictionary = {}
var active_tasks : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_tasks()


func load_tasks():
	var file = FileAccess.open("res://Data/tasks.json", FileAccess.READ)
	var result = JSON.parse_string(file.get_as_text())
	for task in result:
		tasks[task["id"]] = task
