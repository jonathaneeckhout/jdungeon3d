class_name AttackBehavior
extends Component

## When aggroed, the time between 2 path search
const TIME_BEFORE_NEXT_PATH_SEARCH: float = 1.0

@export var navigation_agent: NavigationAgent3D = null

@export var movement_speed_component: MovementSpeedComponent = null
@export var attack_component: AttackComponent = null

@export var aggro_box: Area3D = null

@export var hit_box: Area3D = null

var _current_target: CharacterBody3D = null

var _line_of_sight_raycast: RayCast3D = null

# Timer used to delay searching for a new path. Mainly used to save some cpu power
var _search_path_timer: Timer = null

# Timer to keep track of the timeout between two attacks
var _attack_timer: Timer = null

var _targets_in_aggro_range: Array[CharacterBody3D] = []
var _targets_in_hit_range: Array[CharacterBody3D] = []

var _gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	# Init the line of sight raycast
	_line_of_sight_raycast = RayCast3D.new()
	_line_of_sight_raycast.name = "LineOfSightRaycast"
	_line_of_sight_raycast.collision_mask = Utils.PHYSICS_LAYER_WORLD
	add_child(_line_of_sight_raycast)

	_search_path_timer = Timer.new()
	_search_path_timer.one_shot = true
	_search_path_timer.name = "SearchPathTimer"
	_search_path_timer.wait_time = TIME_BEFORE_NEXT_PATH_SEARCH
	add_child(_search_path_timer)

	# Create a new timer to keep track of the time between attacks
	_attack_timer = Timer.new()
	_attack_timer.name = "AttackTimer"
	_attack_timer.one_shot = true
	add_child(_attack_timer)

	aggro_box.area_entered.connect(_on_aggro_area_area_entered)
	aggro_box.area_exited.connect(_on_aggro_area_area_exited)

	hit_box.area_entered.connect(_on_hit_box_area_entered)
	hit_box.area_exited.connect(_on_hit_box_area_exited)


func attack(delta: float):
	if _current_target == null:
		return

	var target_health_component: HealthComponent = _current_target.component_list.get_component(
		"HealthComponent"
	)

	if target_health_component.is_dead:
		_current_target = null
		_select_first_alive_target()
		return

	# Attack the target
	if _targets_in_hit_range.has(_current_target):
		# Don't do anything if the attack timer is running, this means your attack is still on timeout
		if !_attack_timer.is_stopped():
			return

		var damage: float = attack_component.get_attack_power()

		target_health_component.take_damage(damage)

		_attack_timer.start(attack_component.attack_speed)

	elif _is_target_in_line_of_sight(_current_target):
		# Move towards the target
		actor.velocity = (
			actor.position.direction_to(_current_target.position)
			* movement_speed_component.run_speed
		)
		actor.move_and_slide()
	else:
		# If the target's position has changed and the search path timer is not running, calculate a new path towards the target
		if _search_path_timer.is_stopped():
			# This will trigger a new calculation of the navigation path
			navigation_agent.set_target_position(_current_target.position)
			# Start the search path timer to limit the amount of navigation path searches
			_search_path_timer.start()
		var current_agent_position: Vector3 = actor.global_position
		var next_path_position: Vector3 = navigation_agent.get_next_path_position()

		actor.velocity = (
			current_agent_position.direction_to(next_path_position)
			* movement_speed_component.run_speed
		)

		if not actor.is_on_floor():
			actor.velocity.y -= _gravity * delta

		actor.move_and_slide()


func has_target():
	return _current_target != null


func _select_first_alive_target():
	_current_target = null

	for target: CharacterBody3D in _targets_in_aggro_range:
		if target.get("component_list") == null:
			continue

		var health_component: HealthComponent = target.component_list.get_component(
			"HealthComponent"
		)

		if health_component == null:
			return

		if health_component.is_dead:
			return

		_current_target = target

		return


func _is_target_in_line_of_sight(target: CharacterBody3D) -> bool:
	# Set the direction of the ray
	_line_of_sight_raycast.target_position = target.position - actor.position
	# Update the raycast
	_line_of_sight_raycast.force_raycast_update()

	return not _line_of_sight_raycast.is_colliding()


func _on_aggro_area_area_entered(area: Area3D):
	var target: CharacterBody3D = area.get_parent()

	if not _targets_in_aggro_range.has(target):
		_targets_in_aggro_range.append(target)

		# If you're not targetting anything yet, pick the first one available
		if _current_target == null:
			_select_first_alive_target()


func _on_aggro_area_area_exited(area: Area3D):
	var target: CharacterBody3D = area.get_parent()

	if _targets_in_aggro_range.has(target):
		if _current_target == target:
			_current_target = null

		_targets_in_aggro_range.erase(target)


func _on_hit_box_area_entered(area: Area3D):
	var target: CharacterBody3D = area.get_parent()

	if not _targets_in_hit_range.has(target):
		_targets_in_hit_range.append(target)


func _on_hit_box_area_exited(area: Area3D):
	var target: CharacterBody3D = area.get_parent()

	if _targets_in_hit_range.has(target):
		_targets_in_hit_range.erase(target)
