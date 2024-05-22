class_name AnimationComponent
extends Component

@export var model: Node3D = null
@export var idle_animations: Array[String] = ["Idle"]

var _animation_player: AnimationPlayer = null
var _movement_component: MovementComponent = null


func _ready():
	super._ready()

	_animation_player = model.get_node("AnimationPlayer")
	_animation_player.play("Idle")
	_movement_component = get_node_or_null("../MovementComponent") as MovementComponent


func _process(_delta):
	if not actor.velocity.is_zero_approx():
		if _movement_component == null:
			_animation_player.play("Walk")
		else:
			if _movement_component.sprinting:
				_animation_player.play("Run")
			else:
				_animation_player.play("Walk")
	else:
		play_random_animation(idle_animations)


func play_random_animation(animation_list: Array[String]):
	if animation_list.has(_animation_player.current_animation) and _animation_player.is_playing():
		return

	var random_animation: String = animation_list[randi() % animation_list.size()]
	_animation_player.play(random_animation)
