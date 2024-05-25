class_name AttackComponent
extends Component

signal attacking

@export var hit_box: Area3D = null

@export var minimum_attack_power: float = 5.0
@export var maximum_attack_power: float = 10.0

@export var attack_speed: float = 1.0
## The delay between the attack button being pressed and the attack actually happening
@export var attack_delay: float = 0.5

var _attack_timer: Timer = null
var _attack_delay_timer: Timer = null


func _ready():
	super._ready()

	_attack_timer = Timer.new()
	_attack_timer.one_shot = true
	_attack_timer.name = "AttackTimer"
	add_child(_attack_timer)

	_attack_delay_timer = Timer.new()
	_attack_delay_timer.one_shot = true
	_attack_delay_timer.name = "AttackDelayTimer"
	_attack_delay_timer.timeout.connect(_on_attack_delay_timer_timeout)
	add_child(_attack_delay_timer)


func get_attack_power() -> float:
	return randf_range(minimum_attack_power, maximum_attack_power)


func attack():
	if not _attack_timer.is_stopped():
		return

	_attack_timer.start(attack_speed)

	attacking.emit()

	if attack_delay == 0:
		_hit_targets()
	else:
		_attack_delay_timer.start(attack_delay)


func _hit_targets():
	if hit_box != null:
		var areas = hit_box.get_overlapping_areas()
		for area in areas:
			var body = area.get_parent()
			if body is Enemy:
				var health_component: HealthComponent = body.component_list.get_component(
					"HealthComponent"
				)
				if health_component != null and not health_component.is_dead:
					health_component.take_damage(get_attack_power())


func _on_attack_delay_timer_timeout():
	_hit_targets()
