extends Spatial

var target: Node
var target_pos: Vector3

func _ready() -> void:
	target = get_node("../Character").ball_target

func _physics_process(delta: float) -> void:
	if target:
		target_pos = target.global_transform.origin
	
	translation = lerp(translation, target_pos, 10.0*delta)
