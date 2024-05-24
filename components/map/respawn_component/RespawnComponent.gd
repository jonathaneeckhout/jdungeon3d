class_name RespawnComponent
extends Component

## The node which contains all the to be respawned entities
@export var group_node: Node3D = null

var _respawns: Node = null


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

	_respawns = Node.new()
	_respawns.name = "Respawns"
	add_child(_respawns)

	group_node.child_exiting_tree.connect(_on_group_node_child_exited_tree)


func _on_group_node_child_exited_tree(node: Node):
	if node.get("should_respawn") == null:
		return

	if node.get("respawn_time") == null:
		return

	if node.get("spawn_location") == null:
		return

	if not node.should_respawn:
		return

	var respawn: Respawn = Respawn.new()
	respawn.name = "Respawn_%s" % node.name
	respawn.group_node = group_node
	respawn.entity_scene = load(node.scene_file_path)
	respawn.entity_name = node.name
	respawn.entity_position = node.spawn_location
	respawn.respawn_time = node.respawn_time
	_respawns.add_child(respawn)
