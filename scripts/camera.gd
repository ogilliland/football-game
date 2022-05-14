extends Spatial

export var target_path: NodePath
var target_pos: Vector3

const MIN_Z: float = -15.0
const MAX_Z: float = 15.0
const MIN_X: float = -40.0
const MAX_X: float = 40.0

func _physics_process(delta: float) -> void:
	var target = get_node(target_path)
	if target:
		target_pos = target.global_transform.origin
		target_pos.x = clamp(target_pos.x, MIN_X, MAX_X)
		target_pos.y = 0
		target_pos.z = clamp(target_pos.z, MIN_Z, MAX_Z)
	
	translation = lerp(translation, target_pos, 4.0*delta)
