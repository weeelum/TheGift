extends Control

signal close_requested

# Store all conversations here. Replace with JSON load later if needed.
var conversation_data := {
	"Threads": {
		"Alex": [
			{
				"speaker": "Alex",
				"text": "hey can u help me download some music",
				"replies": ["fine. $5 for 3 songs"]
				}
		],
		"Mom": [
			{
				"speaker": "Mom",
				"text": "Can you help me sell something on eBay?",
				"replies": ["I guess so. Just send me the details."]
			}
		],
	}
}

var current_contact := ""
var contact_to_thread := {
	"Alex": "Alex",
	"Mom": "Mom",
}

# Cached node references (for cleaner code later)
@onready var thread_display = \
$PanelContainer/HBoxContainer/Threads/VBoxContainer/Thread

@onready var reply_options = \
$PanelContainer/HBoxContainer/Threads/VBoxContainer/HBoxContainer/ItemList

@onready var send_btn = \
$PanelContainer/HBoxContainer/Threads/VBoxContainer/HBoxContainer/SendBtn

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
	thread_display.clear()
	
	var thread_key = contact_to_thread.get(contact_name, "")
	if thread_key == "":
		print("No thread for: ", contact_name)
	
	var messages = conversation_data["Threads"].get(thread_key, [])
	for msg in messages:
		var speaker = msg.get("speaker", "")
		var text = msg.get("text", "")
		
		thread_display.append_text("[b]%s:[/b] %s\n" % [speaker, text])
	
	if messages.size() > 0:
		var replies = messages[-1].get("replies", [])
		populate_replies(replies)


func _on_close_pressed():
	emit_signal("close_requested")
	

# Handl reply submission
func _on_SendBtn_pressed() -> void:
	var selected = reply_options.get_selected_items()
	if selected.is_empty():
		return # No reply chosen. Do nothing.
	
	var reply_text = reply_options.get_item_text(selected[0])
	thread_display.append_text("[color=blue]You:[/color] %s\n" % reply_text)
	reply_options.clear()

# Show reply options in ItemList
func populate_replies(replies: Array) -> void:
	reply_options.clear()
	for reply in replies:
		reply_options.add_item(reply)
