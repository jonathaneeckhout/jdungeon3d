extends Component
class_name ComponentHealth

signal health_changed(change_amount: float)
signal health_max_changed(change_amount: float)

@export var current: float
@export var maximum: float

func set_max_health(new_amount: float):
	var old_max: float = maximum
	maximum = clamp(new_amount, 0, INF)
	
	#Update health to respect the new maximum
	set_health(current)
	
	health_max_changed.emit(new_amount - old_max)
	

func get_max_health() -> float:
	return maximum


func set_health(new_amount: float):
	var old_health: float = current
	current = clamp(new_amount, 0, maximum)
	
	health_changed.emit(new_amount - old_health)

func get_health() -> float:
	return current
