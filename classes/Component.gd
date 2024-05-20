class_name Component
extends Node

@export var actor: Node3D = null

var _component_list: ComponentList = null


func _ready():
	_component_list = get_parent()
	_component_list.register_component(self)

	#Wait an additional frame so others can get set.
	await get_tree().process_frame

	#Some entities take a bit to get added to the tree, do not update them until then.
	if not is_inside_tree():
		await tree_entered

	_link()


func _link():
	pass
