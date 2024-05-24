class_name Player
extends CharacterBody3D

var component_list: ComponentList = null


func _ready():
	component_list = get_node("ComponentList") as ComponentList
