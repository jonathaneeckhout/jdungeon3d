class_name CameraComponent
extends Component

@export var camera_pivot_point: Node3D = null
@export var mouse_sensitivity: float = 0.4
@export var camera_upper_limit: float = 89
@export var camera_lower_limit: float = -89

var _picture_mode_enabled: bool = false


func _ready():
	super._ready()

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event.is_action_pressed("picture_mode"):
		_picture_mode_enabled = not _picture_mode_enabled
		if not _picture_mode_enabled:
			camera_pivot_point.rotation.y = 0

	elif event is InputEventMouseMotion:
		if _picture_mode_enabled:
			# Rotate the player around the axis.
			camera_pivot_point.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))

			# Look up and down.
			camera_pivot_point.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))

			# Ensure not to look too far.
			camera_pivot_point.rotation.x = clamp(
				camera_pivot_point.rotation.x, deg_to_rad(-89), deg_to_rad(89)
			)
			camera_pivot_point.rotation.z = 0
		else:
			# Rotate the player around the axis.
			actor.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))

			# Look up and down.
			camera_pivot_point.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))

			# Ensure not to look too far.
			camera_pivot_point.rotation.x = clamp(
				camera_pivot_point.rotation.x,
				deg_to_rad(camera_lower_limit),
				deg_to_rad(camera_upper_limit)
			)
			camera_pivot_point.rotation.z = 0
