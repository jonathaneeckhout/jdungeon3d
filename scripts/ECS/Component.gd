extends Node3D
class_name Component
## This serves as a base for all components, all of them will automatically register themselves in a static, shared variable.
## The components are registered under an ID which is shared with the entity that owns them.
## This means that you can always rely on the ID of the parent to find the components.
##
## The ID of each object is currently sourced from their instance ID, but it can be anything.

static var component_master_dict: Dictionary

static var script_identifier_cache_dict: Dictionary

func _enter_tree() -> void:
	## Automatically register this component
	register_to_id(
		get_id()
		)

func register_to_id(owner_id: int):
	var global_name: String = Component.get_script_identifier(get_script())
	
	var comp_dict: Dictionary = Component.component_master_dict.get(global_name, {})
	
	comp_dict[owner_id] = self
	
	Component.component_master_dict[global_name] = comp_dict

func get_id() -> int:
	var id: int = Component.get_id_of_entity(get_parent())
	return id

## This may be called without the need of an instance.
## Example: var player_health: ComponentHealth = ComponentHealth.get_by_id(Component.get_id_of_entity($Player))
static func get_by_id(script: Script, id: int) -> Component:
	return component_master_dict.get(Component.get_script_identifier(script), {}).get(id, null)

static func get_all(script: Script) -> Array[Component]:
	var output: Array[Component] = []
	var global_name: String = Component.get_script_identifier(script)
	output.assign(component_master_dict.get(global_name, {}).values())
	return output

func get_entity_by_id(id: int) -> Object:
	return instance_from_id(id)

static func get_id_of_entity(node: Node) -> int:
	return node.get_instance_id()

static func get_all_entity_ids(script: Script) -> Array[int]:
	var output: Array[int] = []
	var global_name: String = Component.get_script_identifier(script)
	output.assign(component_master_dict.get(global_name, {}).keys())
	return output

static func get_script_identifier(script: Script) -> String:
	var identifier: String = script_identifier_cache_dict.get(script, "")
	if identifier == "":
		identifier = str(script.resource_path.get_file())
	
	script_identifier_cache_dict[script] = identifier
	return identifier
