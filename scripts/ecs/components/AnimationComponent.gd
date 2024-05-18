extends Component
class_name ComponentAnimation

enum Animations {IDLE, MOVING, JUMP}

@export_group("Animation names","anim_name")
@export var anim_name_default: StringName
@export var anim_name_idle: StringName
@export var anim_name_move: StringName
@export var anim_name_attack: StringName
@export var anim_name_airborne: StringName


## May be an AnimationPlayer or a node that has an AnimationPlayer as a child
@export var animation_node: Node
var animation_current: StringName

func set_animation_node(val: Node):
	animation_node = val
	
	
func get_animation_node() -> AnimationPlayer:
	if animation_node is AnimationPlayer:
		return animation_node
	else:
		return animation_node.get_node("AnimationPlayer")
	
