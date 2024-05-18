extends CharacterBody3D

const WALK_SPEED = 2.5
const SPRINT_SPEED = 5.0
const JUMP_VELOCITY = 4.5

## Mouse sensitivity of the player.
@export var mouse_sensitivity: float = 0.4

@onready var head: Node3D = %Head

@onready var Model: Node3D = %Model

var animation_player: AnimationPlayer = null

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var left_mouse_pressed = false
var right_mouse_pressed = false
var sprinting_pressed = false
var animation_done = true


func _ready():
	animation_player = Model.get_node("AnimationPlayer")
	animation_player.play("Idle")


# Handles mouse motion input to rotate the player and look up and down.
func _input(event):
	if event.is_action_pressed("left_click"):
		left_mouse_pressed = true
	elif event.is_action_released("left_click"):
		left_mouse_pressed = false
	elif event.is_action_pressed("right_click"):
		# Hide the mouse cursor.
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		right_mouse_pressed = true
	elif event.is_action_released("right_click"):
		# Show the mouse cursor.
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		right_mouse_pressed = false
	elif event.is_action_pressed("attack_1"):
		animation_player.play("Slash")
		animation_done = false
	elif event.is_action_pressed("sprint"):
		sprinting_pressed = true
	elif event.is_action_released("sprint"):
		sprinting_pressed = false

	if event is InputEventMouseMotion:
		if left_mouse_pressed:
			# Rotate the player around the axis.
			head.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))

			# Look up and down.
			head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))

			# Ensure not to look too far.
			head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
			head.rotation.z = 0
		elif right_mouse_pressed:
			# Rotate the player around the axis.
			rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))

			# Look up and down.
			head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))

			# Ensure not to look too far.
			head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
			head.rotation.z = 0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	var speed: float = 0.0
	if sprinting_pressed:
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	if not animation_done:
		if animation_player.is_playing():
			pass
		else:
			animation_done = true
	elif not is_on_floor():
		# animation_player.play("jump")
		pass
	elif velocity.is_zero_approx():
		animation_player.play("Idle")
	else:
		if sprinting_pressed:
			animation_player.play("Running")
		else:
			animation_player.play("Walking")

	move_and_slide()
