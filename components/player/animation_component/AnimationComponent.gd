class_name AnimationComponent
extends Component

@export var model: Node3D = null

var _animation_player: AnimationPlayer = null
var _movement_component: MovementComponent = null
var _animation_done = true


func _ready():
	register_component()

	_animation_player = model.get_node("AnimationPlayer")
	_movement_component = get_node("../MovementComponent") as MovementComponent


func _process(_delta):
	if not _animation_done:
		if _animation_player.is_playing():
			pass
		else:
			_animation_done = true
	elif not actor.is_on_floor():
		# animation_player.play("jump")
		pass
	elif actor.velocity.is_zero_approx():
		_animation_player.play("Idle")
	else:
		if _movement_component.sprinting:
			_animation_player.play("Running")
		else:
			_animation_player.play("Walking")
