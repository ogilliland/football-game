extends KinematicBody

# Constants are defined as accelerations (in m/s^2)
const ACCEL: float = 60.0
const FRICTION: float = 8.0

onready var animation_tree = $AnimationTree
onready var ball_target = $BallTarget
onready var ball_capture_area = $BallCaptureArea

var velocity: Vector3
var has_ball: float = false
var ball: Spatial

func _physics_process(delta: float) -> void:
	var direction := Vector3(
	Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
	0,
	Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	
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

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action_pass") and has_ball:
		ball_capture_area.monitoring = false
		ball_capture_area.get_node("ResetTimer").start()
		ball.clear_target()
		var impulse = 10 * global_transform.basis.z
		impulse += 5 * Vector3.UP
		ball.apply_central_impulse(impulse)
		has_ball = false

func _on_ball_capture_area_body_entered(body: PhysicsBody) -> void:
	if body.name == "Ball":
		body.set_target(ball_target)
		ball = body
		has_ball = true

func _on_ball_capture_area_timeout():
	ball_capture_area.monitoring = true
