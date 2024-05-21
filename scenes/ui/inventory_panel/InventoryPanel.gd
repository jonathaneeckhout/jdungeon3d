class_name InventoryPanel
extends PanelContainer

@export var width: int = 4
@export var height: int = 4
@export var inventory_component: InventoryComponent = null

var _inventory_slot_scene: PackedScene = preload(
	"res://scenes/ui/inventory_panel/InventorySlot.tscn"
)

var _slots: Array[Array] = []

@onready var _inventory_grid: GridContainer = %InventoryGrid


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []

	if inventory_component == null:
		warnings.append(
			"inventory component is null, please add the inventory component to the component list"
		)

	return warnings


func _ready():
	_inventory_grid.columns = width

	# Create the inventory slots
	for x in range(width):
		_slots.append([])
		for y in range(height):
			_slots[x].append(null)

	for x in range(width):
		for y in range(height):
			var slot: InventorySlot = _inventory_slot_scene.instantiate()
			slot.name = "Slot_%s_%s" % [x, y]
			_inventory_grid.add_child(slot)
			_slots[x][y] = slot

	inventory_component.inventory_changed.connect(_on_inventory_changed)


func _input(event):
	if event.is_action_pressed("open_inventory"):
		if is_visible():
			hide()
		else:
			show()


func set_all_slots():
	var i: int = 0
	for x in range(width):
		for y in range(height):
			var slot: InventorySlot = _slots[x][y]

			var item: Item = inventory_component.get_inventory_item(i)
			if item != null:
				slot.set_inventory_item(item)

			i += 1


func clear_all_slots():
	for x in range(width):
		for y in range(height):
			var slot: InventorySlot = _slots[x][y]
			slot.clear_inventory_item()


func _on_inventory_changed():
	clear_all_slots()
	set_all_slots()
