extends Component
class_name ComponentInput

enum Actions {
	MOVE_FORWARD,
	MOVE_BACK,
	MOVE_LEFT,
	MOVE_RIGHT,
	ATTACK,
}

var look_rotation: Vector3

var pressed_actions: Dictionary

func set_action_pressed(action: Actions, pressed: bool):
	pressed_actions[action] = pressed

func is_action_pressed(action: Actions) -> bool:
	return pressed_actions.get(action, false)

func set_look_rotation(val: Vector3):
	look_rotation = val

func get_look_rotation() -> Vector3:
	return look_rotation
