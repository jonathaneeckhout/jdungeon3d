class_name InventoryComponent
extends Component

@export var size: int = 16

@export var inventory: Array[Item] = []
@export var gold: int = 0


func add_item(item: Item) -> bool:
	if item.type == Item.TYPE.CURRENCY:
		add_gold(item.amount)
		return true

	item.collision_layer = 0

	if inventory.size() >= size:
		return false

	inventory.append(item)

	return true


func remove_item(uuid: String) -> bool:
	var item: Item = get_item_by_uuid(uuid)
	if item == null:
		return false

	inventory.erase(item)
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
