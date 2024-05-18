extends Component
class_name ComponentMovement

@export var model_node_reference: Node3D
@export var enabled: bool = true
@export var base_speed: float = 150.0
var movement_vector: Vector3
var on_floor: bool

func set_movement_vector(val: Vector3):
	movement_vector = val
	

func get_movement_vector() -> Vector3:
	return movement_vector
	

func set_base_speed(val: float):
	base_speed = val
		

func get_base_speed() -> float:
	return base_speed


func get_entity_position(global: bool = false) -> Vector3:
	if global:
		return get_parent().global_position
	else:
		return get_parent().position

func set_enabled(val: bool):
	enabled = val
		

func is_enabled() -> bool:
	return enabled

func set_on_floor(val: bool):
	on_floor = val
	
func is_on_floor() -> bool:
	return on_floor
