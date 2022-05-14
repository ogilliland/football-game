extends Position3D

func _physics_process(_delta: float) -> void:
	translation.y = 0.2 * sin(OS.get_ticks_msec() * 0.001)
	translation.z = 0.2 * cos(OS.get_ticks_msec() * 0.001)
