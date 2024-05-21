class_name LootPreview
extends PanelContainer

@onready var loot_label: Label = %LootLabel


func set_loot_label(loot_name: String):
	loot_label.text = loot_name
