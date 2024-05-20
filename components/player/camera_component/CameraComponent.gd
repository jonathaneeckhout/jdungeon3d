class_name CameraComponent
extends Component

@export var camera_pivot_point: Node3D = null
@export var mouse_sensitivity: float = 0.4
@export var camera_upper_limit: float = 89
@export var camera_lower_limit: float = -50

var _mouse_captured: bool = true


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_mouse_captured = !_mouse_captured
		if _mouse_captured:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if event is InputEventMouseMotion:
		# Rotate the player around the axis.
		actor.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))

		# Look up and down.
		camera_pivot_point.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))

		# Ensure not to look too far.
		camera_pivot_point.rotation.x = clamp(
			camera_pivot_point.rotation.x, deg_to_rad(camera_lower_limit), deg_to_rad(camera_upper_limit)
		)
		camera_pivot_point.rotation.z = 0


func _ready():
	super._ready()

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
