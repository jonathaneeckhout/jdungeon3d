class_name InventorySlot
extends Panel


func set_inventory_item(item: Item):
	%ItemLabel.text = item.item_class


func clear_inventory_item():
	%ItemLabel.text = ""
