extends Node3D
class_name Component
## This serves as a base for all components, all of them will automatically register themselves in a static, shared variable.
## Each component_dictionary is unique per class of component.
## The instances of components are registered under the ID of their parent, 
## So it is easy to access any other component of the same parent.
## The ID of each object is currently sourced from their instance ID, but it can be anything.

signal component_added(owner_id: int)

static var component_dictionary: Dictionary

func _ready():
	#Automatically register this component
	set_instance(Component.get_owner_id( get_parent() ))
	
	
func set_instance(owner_id: int):
	Component.component_dictionary[owner_id] = self
	component_added.emit(owner_id)
	
	
## This may be called without the need of an instance.
## Example: var player_health: ComponentHealth = ComponentHealth.get_instance(Component.get_owner_id($Player))
static func get_instance(owner_id: int) -> Component:
	return Component.component_dictionary.get(owner_id, null)

	
static func get_all_instances() -> Array[Component]:
	return component_dictionary.values()
	
	
static func get_owner_id(node: Node) -> int:
	return node.get_instance_id()


static func get_all_owner_ids() -> Array[int]:
	return component_dictionary.keys()
