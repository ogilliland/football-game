extends Position3D

var start_pos: Vector3

func _ready() -> void:
	start_pos = translation

func _physics_process(_delta: float) -> void:
	translation.y = start_pos.y + 0.2 * sin(OS.get_ticks_msec() * 0.001)
	translation.z = start_pos.z + 0.2 * cos(OS.get_ticks_msec() * 0.001)
