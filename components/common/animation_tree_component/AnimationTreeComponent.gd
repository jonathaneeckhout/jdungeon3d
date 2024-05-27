class_name AnimationTreeComponent
extends Component

@export var model: Node3D = null

var _animation_tree: AnimationTree = null
var _movement_component: MovementComponent = null
var _attack_component: AttackComponent = null
var _skill_component: SkillComponent = null


func _ready():
	super._ready()

	_animation_tree = model.get_node("AnimationTree")
	_movement_component = get_node("../MovementComponent")
	_attack_component = get_node("../AttackComponent")
	_skill_component = get_node("../SkillComponent")


func _physics_process(_delta: float):
	_animation_tree.set(
		"parameters/conditions/walking",
		(
			not _movement_component.input_direction.is_zero_approx()
			and _movement_component.walking
			and not _attack_component.is_attacking
			and not _skill_component.is_using_skill
		)
	)

	_animation_tree.set(
		"parameters/conditions/running",
		(
			not _movement_component.input_direction.is_zero_approx()
			and not _movement_component.walking
			and not _attack_component.is_attacking
			and not _skill_component.is_using_skill
		)
	)

	_animation_tree.set(
		"parameters/conditions/idle",
		(
			_movement_component.input_direction.is_zero_approx()
			and not _attack_component.is_attacking
			and not _skill_component.is_using_skill
		)
	)

	_animation_tree.set(
		"parameters/conditions/attacking",
		_attack_component.is_attacking and not _skill_component.is_using_skill
	)

	_animation_tree.set(
		"parameters/conditions/using_skill",
		_skill_component.is_using_skill and not _attack_component.is_attacking
	)

	_animation_tree.set(
		"parameters/AttackStateMachine/conditions/attacking",
		_attack_component.is_attacking and not _skill_component.is_using_skill
	)

	_animation_tree.set(
		"parameters/WalkBlendSpace2D/blend_position",
		Vector2(_movement_component.input_direction.x, _movement_component.input_direction.y)
	)

	_animation_tree.set(
		"parameters/RunBlendSpace2D/blend_position",
		Vector2(_movement_component.input_direction.x, _movement_component.input_direction.y)
	)
