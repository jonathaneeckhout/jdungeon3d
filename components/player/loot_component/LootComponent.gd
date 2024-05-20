@tool

class_name LootComponent
extends Component

signal item_selected(item: Item)
signal item_deselected(item: Item)

@export var loot_area: Area3D = null
@export var loot_scan_depth: float = 1000
@export var loot_preview: LootPreview = null

var _items_in_loot_range: Array[Item] = []
var _right_mouse_pressed: bool = false
var _selected_item: Item = null


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []

	if loot_area == null:
		warnings.append("loot area is null, please link a loot area")

	return warnings


func _ready():
	# The loot area should not be in any collision layer
	loot_area.collision_layer = 0

	# But it should look for items
	loot_area.collision_mask = Utils.PHYSICS_LAYER_ITEMS

	loot_area.area_entered.connect(_on_loot_area_entered)
	loot_area.area_exited.connect(_on_loot_area_exited)


func _input(event):
	if event.is_action_pressed("right_click"):
		_right_mouse_pressed = true
	elif event.is_action_released("right_click"):
		_right_mouse_pressed = false
	elif event is InputEventMouseMotion:
		if not _right_mouse_pressed:
			_selected_item = _get_items_under_mouse(event.position)
			_update_loot_preview()


func _get_items_under_mouse(mouse_position: Vector2) -> Item:
	var camera: Camera3D = get_viewport().get_camera_3d()

	var worldspace = camera.get_world_3d().direct_space_state

	var start = camera.project_ray_origin(mouse_position)

	var end = camera.project_position(mouse_position, loot_scan_depth)

	var parameters: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new()
	parameters.collide_with_bodies = false
	parameters.collide_with_areas = true
	parameters.collision_mask = Utils.PHYSICS_LAYER_ITEMS
	parameters.from = start
	parameters.to = end

	var result: Dictionary = worldspace.intersect_ray(parameters)
	if result.has("collider"):
		var area = result["collider"]
		if area is Area3D:
			var item = area.get_parent()
			if item is Item:
				return item

	return null


func _update_loot_preview():
	if loot_preview == null:
		return

	loot_preview.hide()

	if not _items_in_loot_range.has(_selected_item):
		return

	if _selected_item == null:
		return

	loot_preview.set_loot_label(_selected_item.item_class)
	loot_preview.show()


func _on_loot_area_entered(area: Area3D):
	var item = area.get_parent()
	if item is Item:
		_items_in_loot_range.append(item)


func _on_loot_area_exited(area: Area3D):
	var item = area.get_parent()
	if item is Item:
		_items_in_loot_range.erase(item)
