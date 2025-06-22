extends Control

signal close_requested

var tasks : Dictionary = {}
var active_tasks : Dictionary = {}

@onready var descriptions := %Descriptions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%CloseBtn.pressed.connect(_on_close_pressed)
	
	GameManager.load_tasks()
	display_task("alex_batch_1_accept")


func display_task(task_id: String) -> void:
	# Clear existing rows
	for child in descriptions.get_children():
		child.queue_free()

	var task = GameManager.tasks.get(task_id)
	if task == null:
		return

	# What keys and values to show
	var display_keys := {
		"Task:": task["task"],
		"Description:": task["description"],
		"XP:": str(task["rewards"].get("xp", 0)),
		"Money:": str(task["rewards"].get("money", 0)),
		"Status:": task["status"]
	}

	for key in display_keys:
		var row := HBoxContainer.new()
		row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		row.size_flags_vertical = Control.SIZE_FILL
		row.alignment = BoxContainer.ALIGNMENT_BEGIN

		# --- Key label (smaller and left-aligned)
		var key_label := Label.new()
		key_label.text = key
		key_label.add_theme_font_size_override("font_size", 16)
		key_label.autowrap_mode = TextServer.AUTOWRAP_OFF
		key_label.size_flags_horizontal = Control.SIZE_FILL
		key_label.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		key_label.custom_minimum_size = Vector2(90, 0)
		key_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT

		# --- Value label (larger, wrapped, flexible)
		var value_label := Label.new()
		value_label.text = display_keys[key]
		value_label.add_theme_font_size_override("font_size", 20)
		value_label.autowrap_mode = TextServer.AUTOWRAP_WORD
		value_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		value_label.size_flags_vertical = Control.SIZE_FILL
		value_label.custom_minimum_size = Vector2(0, 0)
		value_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT

		row.add_child(key_label)
		row.add_child(value_label)

		descriptions.add_child(row)
		

func _on_close_pressed():
	emit_signal("close_requested")
