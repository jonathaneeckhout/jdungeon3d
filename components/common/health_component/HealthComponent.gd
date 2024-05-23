extends Component
class_name HealthComponent

signal health_changed(change_amount: float)
signal healed(amount: float)
signal hurt(amount: float)
signal died
signal health_max_changed(change_amount: float)

@export var health: float = 100
@export var maximum: float = 100

var is_dead: bool = false


func set_max_health(new_amount: float):
	var old_max: float = maximum
	maximum = clamp(new_amount, 0, INF)

	#Update health to respect the new maximum
	set_health(health)

	health_max_changed.emit(new_amount - old_max)


func get_max_health() -> float:
	return maximum


func set_health(new_amount: float):
	var old_health: float = health
	health = clamp(new_amount, 0, maximum)

	health_changed.emit(new_amount - old_health)

	if health <= 0:
		is_dead = true
		died.emit()


func heal(amount: float):
	healed.emit(amount)

	set_health(health + amount)


func take_damage(amount: float):
	hurt.emit(amount)

	set_health(health - amount)


func get_health() -> float:
	return health
