extends KinematicBody

# Constants are defined as accelerations (in m/s^2)
const ACCEL: float = 60.0
const FRICTION: float = 8.0

onready var animation_tree = $AnimationTree
onready var ball_target = $BallTarget

var velocity: Vector3

func _physics_process(delta: float) -> void:
	var direction := Vector3(
	Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
	0,
	Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	
	# TO DO - fix bug where diagonals are slower with controller
	var direction_abs = clamp(direction.length(), 0.0, 1.0)
	direction = direction.normalized() * direction_abs
	
	velocity += direction * ACCEL * delta
	velocity -= velocity * FRICTION * delta
	
	velocity = move_and_slide(velocity, Vector3.UP)
	
	var velocity_percent = clamp(velocity.length() / 6.5, 0.0, 1.0)
	
	# Update ball position if player has control
	ball_target.translation.z = 0.25 + 0.75 * velocity_percent
	
	# Update dynamic animations
	animation_tree.update(velocity_percent)
	
	# Rotate character to face velocity direction
	if velocity.length() > 0.1:
		var target = Transform(
		Vector3(1, 0, 0),
		Vector3(0, 1, 0),
		Vector3(0, 0, 1),
		Vector3(0, 0, 0)
		)
		var angle = atan2(velocity.x, velocity.z)
		target = target.rotated(Vector3.UP, angle)
		
		# Convert basis to quaternion
		var a = Quat(transform.basis)
		var b = Quat(target.basis)
		# Interpolate using spherical-linear interpolation (SLERP)
		var c = a.slerp(b, 0.25)
		transform.basis = Basis(c)
