extends Component
class_name ComponentInput

enum Actions {
	MOVE_FORWARD,
	MOVE_BACK,
	MOVE_LEFT,
	MOVE_RIGHT,
	ATTACK,
}

var targeted_direction: Vector3

var pressed_actions: Dictionary

func set_action_pressed(action: Actions, pressed: bool):
	pressed_actions[action] = pressed

func is_action_pressed(action: Actions) -> bool:
	return pressed_actions.get(action, false)

func set_targeted_direction(val: Vector3):
	targeted_direction = val

func get_targeted_direction() -> Vector3:
	return targeted_direction
