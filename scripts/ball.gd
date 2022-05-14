extends RigidBody

var target: Node
var target_pos: Vector3

onready var shadow = $Shadow
onready var raycast = $RayCast

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
	var shadow_pos = raycast.get_collision_point()
	var height = clamp((global_transform.origin - shadow_pos).y - 0.125, 0.0, 10.0)
	shadow.scale.x = 0.5 + height*0.05
	shadow.scale.y = 0.5 + height*0.05
	shadow.translation.y = -0.1 - height
	
	if target:
		target_pos = target.global_transform.origin
		translation = lerp(translation, target_pos, 10.0*delta)
