class_name InventoryComponent
extends Component

signal inventory_changed

@export var size: int = 16
@export var inventory: Array[Item] = []
@export var gold: int = 0


func get_inventory() -> Array[Item]:
	return inventory


func get_inventory_item(index: int) -> Item:
	if index < 0 or index >= inventory.size():
		return null

	return inventory[index]


func add_item(item: Item) -> bool:
	if item.type == Item.TYPE.CURRENCY:
		add_gold(item.amount)
		return true

	if inventory.size() >= size:
		return false

	inventory.append(item)

	inventory_changed.emit()

	return true


func remove_item(uuid: String) -> bool:
	var item: Item = get_item_by_uuid(uuid)
	if item == null:
		return false

	inventory.erase(item)

	inventory_changed.emit()

	return true


func get_item_by_uuid(uuid: String) -> Item:
	for item in inventory:
		if item.uuid == uuid:
			return item

	return null


func add_gold(amount: int) -> bool:
	gold += amount

	return true


func remove_gold(amount: int) -> bool:
	if gold < amount:
		return false

	gold -= amount

	return true
