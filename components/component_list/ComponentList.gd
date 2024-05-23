class_name ComponentList
extends Node
## Keeps track of components for an actor/entity and contains methods for finding them.
## ComponentLists are stored under an int based on their actor property.
const EMPTY_COMP_ARR: Array[Component] = []

@export var actor: Node3D = null

var _components: Dictionary = {}

## Stores int:ComponentList pairs, used to find lists by the actor id
static var _list_dictionary: Dictionary

## Stores String:Array[Component] pairs, to rapidly find specific components in all lists
static var _global_component_cache: Dictionary

### SETUP ###


func _ready():
	if actor == null:
		GodotLogger.error("Actor is null")
		return

	var actor_id: int = ComponentList.get_object_id(actor)
	_list_dictionary[actor_id] = self


func _exit_tree() -> void:
	var actor_id: int = ComponentList.get_object_id(actor)
	_list_dictionary.erase(actor_id)

	## If readded for any reason, re-do the initial checks
	request_ready()


func register_component(component: Component) -> void:
	var component_identifier: String = ComponentList.get_component_identifier(component)
	var new_arr: Array[Component] = []

	component.actor = actor

	if _components.has(component_identifier):
		GodotLogger.error("Component already registered under this list.")
		return

	_components[component_identifier] = component
	new_arr.assign(_global_component_cache.get(component_identifier, EMPTY_COMP_ARR) + [component])
	_global_component_cache[component_identifier] = new_arr


### GETTERS ###


func get_component(comp_identifier: String) -> Component:
	return _components.get(comp_identifier, null)


func get_actor_id() -> int:
	return ComponentList.get_object_id(actor)


### STATIC GETTERS ###


static func get_component_in_list(list_id: int, comp_identifier: String) -> Component:
	var list: ComponentList = ComponentList.get_list(list_id)
	var component: Component = list.get_component(comp_identifier)
	return component


static func get_components_in_all_lists(comp_identifier: String) -> Array[Component]:
	return _global_component_cache.get(comp_identifier, EMPTY_COMP_ARR)


static func get_list(id: int) -> ComponentList:
	return _list_dictionary.get(id, null)


static func get_lists_in_all_objects() -> Array[ComponentList]:
	var output: Array[ComponentList] = []
	output.assign(_list_dictionary.values())
	return output


static func get_object_id(obj: Object) -> int:
	return obj.get_instance_id()


static func get_component_identifier(component: Component) -> String:
	return component.get_script().resource_path.get_file()
