class_name CameraComponent
extends Component

@export var camera_pivot_point: Node3D = null
@export var mouse_sensitivity: float = 0.4
@export var camera_upper_limit: float = 89
@export var camera_lower_limit: float = -89

var _last_mouse_position: Vector2 = Vector2.ZERO
var _left_mouse_pressed: bool = true
var _right_mouse_pressed: bool = false
var _picture_mode_enabled: bool = false


func _input(event):
	if event.is_action_pressed("left_click"):
		_left_mouse_pressed = true
	elif event.is_action_released("left_click"):
		_left_mouse_pressed = false
	elif event.is_action_pressed("right_click"):
		# Hide the mouse cursor.
		_last_mouse_position = event.position
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		_right_mouse_pressed = true
	elif event.is_action_released("right_click"):
		# Show the mouse cursor.
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

		# Set the mouse at the last position.
		Input.warp_mouse(_last_mouse_position)
		_right_mouse_pressed = false
	elif event.is_action_pressed("picture_mode"):
		_picture_mode_enabled = not _picture_mode_enabled
		if not _picture_mode_enabled:
			camera_pivot_point.rotation.y = 0

			# Show the mouse cursor.
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

			# Set the mouse at the last position.
			Input.warp_mouse(_last_mouse_position)
		else:
			# Hide the mouse cursor.
			_last_mouse_position = actor.get_viewport().get_mouse_position()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

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
		elif _right_mouse_pressed:
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
