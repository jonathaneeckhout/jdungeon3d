class_name Enemy
extends CharacterBody3D

## The name of the class of the enemy
@export var enemy_class: String = ""
@export var should_respawn: bool = true
@export var respawn_time: float = 10.0

var spawn_location: Vector3 = Vector3.ZERO

var component_list: ComponentList = null


func _ready():
	spawn_location = position

	component_list = get_node("ComponentList") as ComponentList
