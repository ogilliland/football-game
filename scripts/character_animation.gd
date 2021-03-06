extends AnimationTree

func update(intensity: float) -> void:
	set("parameters/blend_move/blend_position", intensity*2.0 - 1.0)
	set("parameters/time_scale/scale", intensity*3.0 + 1.0)
	set("parameters/blend_arms/blend_amount", intensity)
	set("parameters/blend_lean/blend_position", intensity*2.0 - 1.0)
