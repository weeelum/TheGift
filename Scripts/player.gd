extends Node2D

signal score_increased

var score := 0


func increase_score(amount : int):
	score += amount
	emit_signal("score_increased")
