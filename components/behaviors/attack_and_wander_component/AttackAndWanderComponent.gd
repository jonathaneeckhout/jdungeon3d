class_name AttackAndWanderComponent
extends Component

@export var navigation_agent: NavigationAgent3D = null:
	set(value):
		navigation_agent = value
		_wander_behavior.navigation_agent = value

@export var movement_speed: float = 5.0:
	set(value):
		movement_speed = value
		_wander_behavior.movement_speed = value

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

var _wander_behavior: WanderBehavior = WanderBehavior.new()

var _health_component: HealthComponent = null


func _ready():
	super._ready()

	_wander_behavior.actor = actor
	_wander_behavior.name = "WanderBehavior"
	add_child(_wander_behavior)

	_health_component = get_node("../HealthComponent")


func _physics_process(delta: float):
	if _health_component.is_dead:
		return

	behavior(delta)


func behavior(delta: float):
	# TODO: Implement attack behavior
	_wander_behavior.wander(delta)
