class_name AttackAndWanderComponent
extends Component

@export var aggro_box: Area3D = null:
	set(value):
		aggro_box = value
		_attack_behavior.aggro_box = value

@export var hit_box: Area3D = null:
	set(value):
		hit_box = value
		_attack_behavior.hit_box = value

@export var navigation_agent: NavigationAgent3D = null:
	set(value):
		navigation_agent = value
		_attack_behavior.navigation_agent = value
		_wander_behavior.navigation_agent = value

## The time the parent should stay idle before wandering
@export var idle_time: float = 10.0:
	set(value):
		idle_time = value
		_wander_behavior.idle_time = value

## The distance from the starting position the parent can wander
@export var wander_distance: float = 20.0:
	set(value):
		wander_distance = value
		_wander_behavior.wander_distance = value

var _attack_behavior: AttackBehavior = AttackBehavior.new()
var _wander_behavior: WanderBehavior = WanderBehavior.new()

var _health_component: HealthComponent = null
var _movement_speed_component: MovementSpeedComponent = null
var _attack_component: AttackComponent = null


func _ready():
	super._ready()

	_attack_behavior.actor = actor
	_attack_behavior.name = "AttackBehavior"
	add_child(_attack_behavior)

	_wander_behavior.actor = actor
	_wander_behavior.name = "WanderBehavior"
	add_child(_wander_behavior)

	_health_component = get_node("../HealthComponent")
	_movement_speed_component = get_node("../MovementSpeedComponent")

	_attack_behavior.movement_speed_component = _movement_speed_component
	_wander_behavior.movement_speed_component = _movement_speed_component

	_attack_component = get_node("../AttackComponent")

	_attack_behavior.attack_component = _attack_component


func _physics_process(delta: float):
	if _health_component.is_dead:
		return
	behavior(delta)


func behavior(delta: float):
	# TODO: Implement attack behavior
	if _attack_behavior.has_target():
		_attack_behavior.attack(delta)
	else:
		_wander_behavior.wander(delta)
