extends Spatial

export var side: String

func _on_area_body_entered(body):
	if body.name == "Ball":
		Score.goal(side)
