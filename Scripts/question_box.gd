# Used to pull parsed JSON data from GameManager singleton to dynamically add
# and adjust questions.

extends Control

#var q_data = GameManager.load_questions()

#func _ready() -> void:
	#if GameManager.questions.size() > 0:
		## Pick the first question
		#pass
		#
		#
		### Populate ItemList with answers
		##var answers = q_data["answer"]
		##var item_list: ItemList = $AnswerList
		##item_list.clear() # Clear any pre-existing items
		##
		##for answer in answers:
			##item_list.add_item(answer)
	#else:
		#push_warning("No questions available!")
