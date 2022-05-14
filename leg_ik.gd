tool
extends Spatial

export var target: NodePath

var joint_length: float

func _ready() -> void:
	var child = get_child(0)
	joint_length = child.get_node(child.child).translation.length()

func _physics_process(_delta: float) -> void:
	update_ik()

func update_ik() -> void:
	var offset = get_node(target).global_transform.origin - global_transform.origin
	var offset_length = offset.length()
	var angles = get_angles(joint_length, offset_length, joint_length)
	var offset_y = offset.dot(global_transform.basis.y)
	var offset_z = offset.dot(global_transform.basis.z)
	var a_prime = atan2(offset_y, offset_z)
	var child = get_child(0)
	child.rotation.x = -1 * (angles.a + a_prime + 0.5*PI)
	child.get_node(child.child).rotation.x = PI - angles.b

func get_angles(side_a: float, side_b: float, side_c: float) -> Dictionary:
	if side_b > side_a + side_c:
		return { "a": 0, "b": PI }
	var angle_a = cosine_rule(side_b, side_c, side_a)
	var angle_b = cosine_rule(side_a, side_c, side_b)
	return { "a": angle_a, "b": angle_b }

func cosine_rule(a: float, b: float, c: float) -> float:
	if 2*a*b == 0:
		return 0.0
	return acos( (a*a + b*b - c*c) / (2*a*b) )
