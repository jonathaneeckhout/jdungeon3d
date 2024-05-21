class_name MovementComponent
extends Component

@export var walk_speed: float = 2.5
@export var run_speed: float = 5.0
@export var jump_velocity: float = 4.5

var sprinting: bool = false

var _gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _input(event):
	if event.is_action_pressed("sprint"):
		sprinting = true
	elif event.is_action_released("sprint"):
		sprinting = false


func _physics_process(delta):
	if not actor.is_on_floor():
		actor.velocity.y -= _gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and actor.is_on_floor():
		actor.velocity.y = jump_velocity

	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (actor.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	var speed: float = walk_speed
	if sprinting:
		speed = run_speed

	if direction:
		actor.velocity.x = direction.x * speed
		actor.velocity.z = direction.z * speed
	else:
		actor.velocity.x = move_toward(actor.velocity.x, 0, speed)
		actor.velocity.z = move_toward(actor.velocity.z, 0, speed)

	actor.move_and_slide()
