extends Node

enum TaskStatus { NOT_STARTED, ACTIVE, COMPLETE, FAILED }
enum ObjectiveType { DOWNLOAD, BUY, TALK, SORT }

var tasks : Dictionary = {}
var active_tasks : Dictionary = {}


func load_tasks():
	var file = FileAccess.open("res://Data/tasks.json", FileAccess.READ)
	var result = JSON.parse_string(file.get_as_text())
	for task in result:
		tasks[task["id"]] = task


func start_task(task_id : String):
	if task_id in tasks:
		var task = tasks[task_id]
		task["status"] = "active"
		active_tasks[task_id] = task
