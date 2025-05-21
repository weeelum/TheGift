"""For managing quiz game data and instancing quiz game."""
extends Node

# Get child scenes ready
@onready var player_node : Node2D = $Player
@onready var helper_node : Node2D = $Helper
@onready var q_boxes : CanvasLayer = $QuestionBoxes
@onready var qstn_node : Label = $QuestionBoxes/QuestionControl/Question
@onready var ans_list_node : ItemList = \
$QuestionBoxes/QuestionControl/AnswerList
@onready var next_qstn_node : Button = \
$QuestionBoxes/QuestionControl/NextQuestion
@onready var score_node : Label = \
$QuestionBoxes/QuestionControl/Score

# Create empty dict to store JSON data.
var questions : Dictionary = {}


# Set starting question index.
var current_q_idx = 0
var _last_selected_q_idx := -1 # indicates no answer chosen yet


func _ready() -> void:
	# Run these actions one time once game starts
	q_boxes.connect("answer_chosen", Callable(self, "_on_item_selected"))
	q_boxes.connect("button_pressed", Callable(self, "_on_button_pressed"))
	player_node.connect("score_increased", Callable(self, "_on_score_increased"))
	
	ans_list_node.visible = false
	next_qstn_node.visible = false
	next_qstn_node.disabled = true
	
	score_node.text = "Score: " + str(player_node.score)
	
	load_json()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("start"):
		ans_list_node.visible = true
		next_qstn_node.visible = true
		fill_QAs(current_q_idx)
	
	if Input.is_action_just_pressed("confirm_answer"):
		_on_button_pressed()


func _on_item_selected(idx: int) -> void:
	_last_selected_q_idx = idx
	next_qstn_node.disabled = false
	print("Main received answer chosen signal with index: ", idx)
	
	
func _on_score_increased() -> void:
	pass
	

func _on_button_pressed() -> void:
	# guard against "nothing chosen"
	if _last_selected_q_idx < 0:
		print("Please select an answer before moving on.")
		return
	
	# safe to check and advance
	if check_answer(_last_selected_q_idx):
		_last_selected_q_idx = -1
		score_node.text = "Score: " + str(player_node.score)
		
		current_q_idx += 1
		if current_q_idx < questions["questions"].size():
			fill_QAs(current_q_idx)
			#next_qstn_node.disabled = true
		else:
			print("Quiz complete!")
	else:
		return


# Loop through ItemList and fill with 'answers' data from converted JSON
func fill_QAs(qstn : int):
	# Retrieve dict and set question text. 
	var data : Dictionary = questions["questions"][qstn]
	qstn_node.text = data["question"]
	ans_list_node.clear()
	
	# Loop through and fill in answers.
	for answer in data["answers"]:
		ans_list_node.add_item(answer)
	

# Check player answer against correct answer index
func check_answer(player_idx : int):
	var correct_idx : int = questions["questions"][current_q_idx]["correct_idx"]
	if player_idx == correct_idx:
		print("Correct! Index: ", player_idx, "\n")
		player_node.increase_score(1)
		return true
	else:
		print("Incorrect. Index: ", player_idx, "\n")
		return false


func load_json():
	var file_path = "res://data/test_questions.json" # adjust path to JSON file
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		var json_str = file.get_as_text()
		file.close()
		
		var json = JSON.new()
		var data = json.parse(json_str)
		if data == OK:
			var data_received = json.data
			if typeof(data_received) == TYPE_DICTIONARY:
				questions = data_received
			else:
				print("Unexpected data.")
	else:
		print("File not found: " + file_path)
