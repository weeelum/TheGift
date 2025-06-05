# SaveManager.gd
extends Node

var save_path := "user://save_game"

# Data to save
var conversation_state := {}
var started_conversations := {}

func save_game():
	var data := {
		"conversation_state": conversation_state,
		"started_conversations": started_conversations,
	}
	
	var file := FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(data)
	file.close()
	print("Game saved.")
	
	
func load_game():
	if !FileAccess.file_exists(save_path):
		print("No save file found.")
		return
	
	var file := FileAccess.open(save_path, FileAccess.READ)
	var data : Dictionary = file.get_var()
	file.close()
	
	conversation_state = data.get("conversation_state", {})
	started_conversations = data.get("started_conversations", {})
	print("Game loaded.")
	

func new_game():
	conversation_state.clear()
	started_conversations.clear()
	
	# Delete previous save file
	if FileAccess.file_exists(save_path):
		OS.move_to_trash(save_path)
	print("New game started")
	
