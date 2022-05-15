extends Control

onready var score_label = $ScoreLabel

func _ready() -> void:
	Score.hud = self
	update_score()

func update_score() -> void:
	var goals = Score.get_score()
	score_label.text = str(goals.left) + " - " + str(goals.right)
