extends CanvasLayer

# Reference child node, AnswerList
@onready var answer_list : ItemList = $QuestionControl/AnswerList
@onready var button : Button = $QuestionControl/NextQuestion

# Define custom signal
signal answer_chosen(player_idx)
signal button_pressed

func _ready() -> void:
	# Connect native item_selected signal to invoke custom method, select_item()
	answer_list.connect("item_selected", Callable(self, "select_item"))
	button.connect("pressed", Callable(self, "next_question"))

func select_item(player_idx : int) -> void:
	# emit custom signal to notify Main node
	emit_signal("answer_chosen", player_idx)


func next_question():
	# Emit custom signal to notify Main node
	emit_signal("button_pressed")
