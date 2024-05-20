class_name Item
extends StaticBody3D

enum TYPE { MICS, QUEST, EQUIPMENT, CONSUMABLE, CURRENCY }

@export var uuid: String = "":
	set(new_uuid):
		uuid = new_uuid
		name = new_uuid

var type: TYPE = TYPE.MICS

var item_class: String = ""


func _init():
	# Disable physics by default
	collision_layer = 0

	collision_mask = 0
