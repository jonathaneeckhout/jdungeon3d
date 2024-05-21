@tool
class_name Item
extends Node3D

enum TYPE { MICS, QUEST, EQUIPMENT, CONSUMABLE, CURRENCY }

## the unique identifier of the item
@export var uuid: String = "":
	set(new_uuid):
		uuid = new_uuid
		name = new_uuid

## The name of the class of the item
@export var item_class: String = ""

## The type of the item
@export var type: TYPE = TYPE.MICS

## The area where the item can be looted
@export var loot_area: Area3D = null


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []

	if loot_area == null:
		warnings.append("loot area is null, please link a loot area")

	return warnings
