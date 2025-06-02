extends Control

signal close_requested

var current_contact := ""
var current_node_id := "start"

# Cache UI
@onready var thread_display : RichTextLabel = %Thread
@onready var reply_options : ItemList = %ItemList
@onready var send_btn : Button = %SendBtn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect Close button signal to close the app
	$PanelContainer/HBoxContainer/VBoxContainer/TopLeftMenu/CloseBtn.\
	pressed.connect(_on_close_pressed)
	
	# Connect Send button for sending replies
	send_btn.pressed.connect(_on_SendBtn_pressed)
	
	# Connect all contact buttons dynamically
	for contact in $PanelContainer/HBoxContainer/VBoxContainer/Contacts/\
	VBoxContainer.get_children():
		contact.pressed.connect(_on_contact_pressed.bind(contact.name))

# Load a conversation when contact is clicked
func _on_contact_pressed(contact_name: String) -> void:
	current_contact = contact_name
	current_node_id = "start"
	thread_display.clear()
	reply_options.clear()
	show_current_node()
	
	#current_contact = contact_name
	#thread_display.clear()
	#
	#var thread_key = contact_to_thread.get(contact_name, "")
	#if thread_key == "":
		#print("No thread for: ", contact_name)
	#
	#var messages = conversation_data["Threads"].get(thread_key, [])
	#for msg in messages:
		#var speaker = msg.get("speaker", "")
		#var text = msg.get("text", "")
		#
		#thread_display.append_text("[b]%s:[/b] %s\n" % [speaker, text])
	#
	#if messages.size() > 0:
		#var replies = messages[-1].get("replies", [])
		#populate_replies(replies)


## Show current conversation thread
func show_current_node() -> void:
	var node = get_current_node()
	if node.is_empty():
		thread_display.append_text("[i]End of conversation.[/i]\n")
		return
	
	thread_display.append_text("[b]%s:[/b] %s\n" % [node.speaker, node.text])
	populate_replies(node.replies)
	

## Get current conversation thread
func get_current_node() -> Dictionary:
	var thread = DD.conversation_data["Threads"].get(current_contact, {})
	return thread.get(current_node_id, {})
	

## Show reply options in ItemList
func populate_replies(replies : Array) -> void:
	reply_options.clear()
	for reply in replies:
		reply_options.add_item(reply.text)
		

# Handle reply submission
func _on_SendBtn_pressed() -> void:
	var selected = reply_options.get_selected_items()
	if selected.is_empty():
		return
	
	var index = selected[0]
	var node = get_current_node()
	var reply = node.replies[index]
	
	thread_display.append_text("[color=blue]You:[/color] %s\n" % reply.text)
	
	match reply.type:
		DD.DialogueType.MISSION:
			start_mission(reply.next_id)
		DD.DialogueType.LORE:
			continue_conversation(reply.next_id)
		_:
			continue_conversation(reply.next_id)
			
	#var selected = reply_options.get_selected_items()
	#if selected.is_empty():
		#return # No reply chosen. Do nothing.
	#
	#var reply_text = reply_options.get_item_text(selected[0])
	#thread_display.append_text("[color=blue]You:[/color] %s\n" % reply_text)
	#reply_options.clear()


func continue_conversation(next_id: String) -> void:
	current_node_id = next_id
	show_current_node()
	
	
func start_mission(next_id : String) -> void:
	## Replace this with actual mission-setup logic
	thread_display.append_text("[i]Mission started![/i]\n")
	continue_conversation(next_id)

func _on_close_pressed():
	emit_signal("close_requested")
