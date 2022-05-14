extends RigidBody

var target: Node
var target_pos: Vector3

func set_target(new_target: Node) -> void:
	target = new_target
	collision_layer = 2
	collision_mask = 2
	sleeping = true

func clear_target() -> void:
	target = null
	collision_layer = 1
	collision_mask = 1
	sleeping = false

func _physics_process(delta: float) -> void:
	if target:
		target_pos = target.global_transform.origin
		translation = lerp(translation, target_pos, 10.0*delta)
