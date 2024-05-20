class_name ComponentList
extends Node

@export var actor: Node3D = null

var _components: Dictionary = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	if actor == null:
		GodotLogger.error("Actor is null")
		return


func register_component(component: Component) -> void:
	component.actor = actor

	var component_identifier = str(component.get_script().resource_path.get_file())

	if _components.has(component_identifier):
		GodotLogger.error("Component already registered")
		return

	_components[component_identifier] = component
