extends Node

var hud: Control

var goals_left: int setget set_goals_left
var goals_right: int setget set_goals_right

func get_score() -> Dictionary:
	return {
		"left": goals_left,
		"right": goals_right
	}

func goal(side: String) -> void:
	if side == "left":
		set_goals_left(goals_left + 1)
	elif side == "right":
		set_goals_right(goals_right + 1)
	else:
		print_debug("Invalid goal target")

func set_goals_left(new_value: int) -> void:
	goals_left = new_value
	hud.update_score()

func set_goals_right(new_value: int) -> void:
	goals_right = new_value
	hud.update_score()

func init() -> void:
	goals_left = 0
	goals_right = 0
