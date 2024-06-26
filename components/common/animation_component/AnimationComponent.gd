class_name AnimationComponent
extends Component

@export var model: Node3D = null
@export var idle_animations: Array[String] = ["Idle"]
@export var attack_animations: Array[String] = ["Attack"]
@export var show_hurt_animation: bool = true

var _animation_player: AnimationPlayer = null
var _health_component: HealthComponent = null
var _movement_component: MovementComponent = null
var _attack_component: AttackComponent = null

var _wait_to_finish: bool = false


func _ready():
	super._ready()

	_animation_player = model.get_node("AnimationPlayer")
	_animation_player.animation_finished.connect(_on_animation_finished)

	if _animation_player.has_animation("Idle"):
		_animation_player.play("Idle")

	_health_component = get_node_or_null("../HealthComponent") as HealthComponent
	if _health_component != null:
		if show_hurt_animation:
			_health_component.hurt.connect(_on_hurt)

		_health_component.died.connect(_on_died)

	_movement_component = get_node_or_null("../MovementComponent") as MovementComponent

	_attack_component = get_node_or_null("../AttackComponent") as AttackComponent
	if _attack_component != null:
		_attack_component.attacked.connect(_on_attack)


func _process(_delta):
	if _wait_to_finish or _health_component.is_dead == true:
		return

	if not actor.velocity.is_zero_approx():
		if _movement_component == null:
			if _animation_player.has_animation("Walk"):
				_animation_player.play("Walk")
		else:
			if _movement_component.walking:
				if _animation_player.has_animation("Walk"):
					_animation_player.play("Walk")
			else:
				if _animation_player.has_animation("Run"):
					_animation_player.play("Run")

	else:
		play_random_animation(idle_animations)


func play_random_animation(animation_list: Array[String]) -> bool:
	if animation_list.has(_animation_player.current_animation) and _animation_player.is_playing():
		return false

	var random_animation: String = animation_list[randi() % animation_list.size()]
	if _animation_player.has_animation(random_animation):
		_animation_player.play(random_animation)
		return true

	return false


func _on_animation_finished(_anim_name: String):
	_wait_to_finish = false


func _on_attack():
	_wait_to_finish = true

	if _animation_player.is_playing():
		_animation_player.stop()

	if play_random_animation(attack_animations):
		_wait_to_finish = true


func _on_hurt(_amount: float):
	_wait_to_finish = false

	if _animation_player.is_playing():
		_animation_player.stop()

	if _animation_player.has_animation("Hurt"):
		_animation_player.play("Hurt")
		_wait_to_finish = true


func _on_died():
	_wait_to_finish = true

	if _animation_player.is_playing():
		_animation_player.stop()

	if _animation_player.has_animation("Die"):
		_animation_player.play("Die")
		_wait_to_finish = true
