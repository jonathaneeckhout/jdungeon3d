class_name CombatComponent
extends Component

signal attacking

@export var hit_box: Area3D = null

var _attack_timer: Timer = null
var _attack_delay_timer: Timer = null
var _attack_pressed: bool = false

var _attack_component: AttackComponent = null


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

	_attack_component = get_node("../AttackComponent") as AttackComponent


func _input(event):
	if event.is_action_pressed("standard_attack"):
		_attack_pressed = true


func _physics_process(_delta):
	if _attack_pressed and _attack_timer.is_stopped():
		_attack_timer.start(_attack_component.attack_speed)
		_attack_pressed = false

		# Attack logic here
		attacking.emit()

		_attack_delay_timer.start(_attack_component.attack_delay)


func _on_attack_delay_timer_timeout():
	# Check for hit
	if hit_box != null:
		var areas = hit_box.get_overlapping_areas()
		for area in areas:
			var body = area.get_parent()
			if body is Enemy:
				var health_component: HealthComponent = body.component_list.get_component(
					"HealthComponent"
				)
				if health_component != null and not health_component.is_dead:
					health_component.take_damage(_attack_component.get_attack_power())
