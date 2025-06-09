#message_app.gd
extends Control

signal close_requested

var current_contact := ""
var current_node_id := "start"
var active_conversations := {}
var conversation_state := {}
var started_conversations := {}
var displayed_thread := {}
var last_contact_button : Button = null

# Cache UI
@onready var thread_display : RichTextLabel = %Thread
@onready var reply_options : ItemList = %ItemList
@onready var send_btn : Button = %SendBtn
@onready var close_btn : Button = %CloseBtn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	## Load conversation states
	load_state()
	
	# Connect Close button signal to close the app
	close_btn.pressed.connect(_on_close_pressed)
	
	# Connect Send button for sending replies
	send_btn.pressed.connect(_on_send_btn_pressed)
	
	# Connect all contact buttons dynamically
	for hbox in %VBoxContainer.get_children():
		for contact_button in hbox.get_children():
			contact_button.pressed.connect(_on_contact_pressed.bind(contact_button))
		

# Load a conversation when contact is clicked
func _on_contact_pressed(contact_button : Button) -> void:
	var contact_name = contact_button.name
	
	# Re-enable previous button, if any
	if last_contact_button:
		last_contact_button.disabled = false
	
	# Disable the new one and store it
	contact_button.disabled = true
	last_contact_button = contact_button
	
	# Restore last saved node ID or start fresh
	current_node_id = conversation_state.get(contact_name, "start")
	
	if current_contact == contact_name and started_conversations.\
	get(contact_name, false):
		return # already in this conversation, so do nothing

	current_contact = contact_name
	started_conversations[contact_name] = true
	
	thread_display.clear()
	reply_options.clear()
	show_current_node()
	

## Get current conversation thread
func get_current_node() -> Dictionary:
	var thread = DD.conversation_data["Threads"].get(current_contact, {})
	return thread.get(current_node_id, {})
	

## Show current conversation thread
func show_current_node() -> void:
	var node = get_current_node()
	var text := "[b]%s:[/b] %s\n" % [node.speaker, node.text]
	var end_text := "[i]End of conversation.[/i]\n"
	
	if node.is_empty():
		thread_display.append_text(end_text)
		displayed_thread[current_contact] = \
		displayed_thread.get(current_contact, "") + end_text
		return
	
	thread_display.append_text(text)
	displayed_thread[current_contact] = \
		displayed_thread.get(current_contact, "") + text
	
	populate_replies(node.replies)


## Show reply options in ItemList
func populate_replies(replies : Array) -> void:
	reply_options.clear()
	for reply in replies:
		reply_options.add_item(reply.text)
		

# Handle reply submission
func _on_send_btn_pressed() -> void:
	var selected = reply_options.get_selected_items()
	var index = selected[0]
	var node = get_current_node()
	var reply = node.replies[index]
	var reply_text := "[color=blue]You:[/color] %s\n" % reply.text
	
	if selected.is_empty():
		return
	
	thread_display.append_text(reply_text)
	displayed_thread[current_contact] = \
		displayed_thread.get(current_contact, "") + reply_text
	
	match reply.type:
		DD.DialogueType.MISSION:
			start_mission(reply.next_id)
		DD.DialogueType.LORE:
			continue_conversation(reply.next_id)
		_:
			continue_conversation(reply.next_id)


func continue_conversation(next_id: String) -> void:
	current_node_id = next_id
	conversation_state[current_contact] = current_node_id
	save_state()
	show_current_node()


func load_state():
	conversation_state = SM.conversation_state
	started_conversations = SM.started_conversations
	displayed_thread = SM.displayed_thread


func save_state():
	SM.conversation_state = conversation_state
	SM.started_conversations = started_conversations
	SM.displayed_thread = displayed_thread
	
	
func start_mission(next_id : String) -> void:
	## Replace this with actual mission-setup logic
	var mission_text := "[i]Mission started![/i]\n"
	
	continue_conversation(next_id)
	
	thread_display.append_text(mission_text)
	displayed_thread[current_contact] = \
		displayed_thread.get(current_contact, "") + mission_text
	

func _on_close_pressed():
	save_state()
	emit_signal("close_requested")
