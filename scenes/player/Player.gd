class_name Player
extends CharacterBody3D

var componnt_list: ComponentList = null


func _ready():
	componnt_list = get_node("ComponentList") as ComponentList
