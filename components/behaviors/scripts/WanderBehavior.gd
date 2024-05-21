class_name WanderBehavior
extends Component

@export var navigation_agent: NavigationAgent3D = null

@export var movement_speed: float = 5.0

## The time the parent should stay idle before wandering
@export var idle_time: float = 10.0

## The distance from the starting position the parent can wander
@export var wander_distance: float = 20.0

# Timer used to check how long the parent should stay idle
var _idle_timer: Timer = null

# The starting position of the parent
var _starting_postion: Vector3


# Make sure to not register to component list
func _ready():
	_idle_timer = Timer.new()
	_idle_timer.one_shot = true
	_idle_timer.name = "IdleTimer"
	_idle_timer.timeout.connect(_on_idle_timer_timeout)
	add_child(_idle_timer)

	navigation_agent.path_desired_distance = 0.5
	navigation_agent.target_desired_distance = 0.5

	# Keep track of the original starting position for later use
	_starting_postion = actor.position

	_idle_timer.start(randf_range(idle_time / 2, idle_time))


func wander():
	if navigation_agent.is_navigation_finished():
		if _idle_timer.is_stopped():
			_idle_timer.start(randf_range(idle_time / 2, idle_time))
			actor.velocity = Vector3.ZERO
		return

	var current_agent_position: Vector3 = actor.global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	actor.velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	actor.move_and_slide()


func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)


func find_random_spot(origin: Vector3, distance: float) -> Vector3:
	return Vector3(
		float(randi_range(origin.x - distance, origin.x + distance)),
		origin.y,
		float(randi_range(origin.z - distance, origin.z + distance))
	)


func _on_idle_timer_timeout():
	set_movement_target(find_random_spot(_starting_postion, wander_distance))
