class_name MovementComponent
extends Component

var walking: bool = false
var input_direction: Vector2 = Vector2.ZERO
var direction: Vector3 = Vector3.ZERO

var _movement_speed_component: MovementSpeedComponent = null
var _attack_component: AttackComponent = null

var _gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	super._ready()

	_movement_speed_component = get_node("../MovementSpeedComponent")
	_attack_component = get_node("../AttackComponent")


func _input(event):
	if event.is_action_pressed("walk"):
		walking = !walking


func _physics_process(delta):
	if not actor.is_on_floor():
		actor.velocity.y -= _gravity * delta
		actor.move_and_slide()
		return

	# Don't move if attacking.
	if _attack_component.is_attacking:
		actor.velocity.x = 0
		actor.velocity.z = 0
		return

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and actor.is_on_floor():
		actor.velocity.y = _movement_speed_component.jump_velocity

	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = (
		(actor.transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()
	)

	var speed: float = _movement_speed_component.run_speed
	if walking:
		speed = _movement_speed_component.walk_speed

	if direction:
		actor.velocity.x = direction.x * speed
		actor.velocity.z = direction.z * speed
	else:
		actor.velocity.x = move_toward(actor.velocity.x, 0, speed)
		actor.velocity.z = move_toward(actor.velocity.z, 0, speed)

	actor.move_and_slide()
