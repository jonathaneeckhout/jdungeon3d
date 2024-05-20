class_name Component
extends Node

@export var actor: Node3D = null

var _component_list: ComponentList = null


func _ready():
	register_component()


func register_component():
	_component_list = get_parent()
	_component_list.register_component(self)
