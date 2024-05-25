class_name AnimationTreeComponent
extends Component

@export var model: Node3D = null

var _animation_tree: AnimationTree = null
var _movement_component: MovementComponent = null


func _ready():
	super._ready()

	_animation_tree = model.get_node("AnimationTree")
	_movement_component = get_node("../MovementComponent")


func _physics_process(_delta: float):
	_animation_tree.set(
		"parameters/conditions/walking", not _movement_component.input_direction.is_zero_approx() and _movement_component.walking
	)
	_animation_tree.set(
		"parameters/conditions/running", not _movement_component.input_direction.is_zero_approx() and not _movement_component.walking
	)
	_animation_tree.set(
		"parameters/conditions/idle", _movement_component.input_direction.is_zero_approx()
	)
	_animation_tree.set(
		"parameters/WalkBlendSpace2D/blend_position",
		Vector2(_movement_component.input_direction.x, _movement_component.input_direction.y)
	)
	_animation_tree.set(
		"parameters/RunBlendSpace2D/blend_position",
		Vector2(_movement_component.input_direction.x, _movement_component.input_direction.y)
	)
