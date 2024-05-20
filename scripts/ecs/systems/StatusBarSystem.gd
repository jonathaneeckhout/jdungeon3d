extends ECSSystem
class_name SatusBarSystem

const COLOR_GOOD := Color.LAWN_GREEN
const COLOR_BAD := Color.RED
const STATUS_BAR_TEXTURE: Texture2D = preload("res://assets/ui/RoundedBar.png")

var status_bar_cache_dict: Dictionary = {}
var ids_registered_arr: Array[int]


func _ready():
	super._ready()

	for client: ComponentClientIdentifier in ECSComponent.get_all(ComponentClientIdentifier):
		register_id(client.get_id())


func _tick():
	for id: int in ids_registered_arr:
		var bounding_box_comp: ComponentBoundingBox = ECSComponent.get_by_id(
			ComponentBoundingBox, id
		)
		var health_comp: ComponentHealth = ECSComponent.get_by_id(ComponentHealth, id)

		if not bounding_box_comp or not health_comp:
			push_warning("Missing components for entity {0}".format([str(id)]))
			continue

		var entity_pos: Vector3 = health_comp.get_parent().global_position
		var status_bar: Sprite3D = status_bar_cache_dict.get(id, null)

		var status_percent: float = health_comp.get_health() / health_comp.get_max_health()
		var status_pos: Vector3 = entity_pos + (Vector3.UP * bounding_box_comp.size.y)

		status_bar.global_position = status_pos
		status_bar.modulate = COLOR_BAD.lerp(COLOR_GOOD, status_percent)
		status_bar.region_rect.size.x = STATUS_BAR_TEXTURE.get_width() * status_percent


func create_status_bar(id: int) -> Sprite3D:
	var sprite_3d := Sprite3D.new()
	sprite_3d.centered = true
	sprite_3d.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	sprite_3d.texture = STATUS_BAR_TEXTURE

	sprite_3d.double_sided = false
	sprite_3d.pixel_size = 0.005

	sprite_3d.region_enabled = true
	sprite_3d.region_rect = Rect2(Vector2.ZERO, STATUS_BAR_TEXTURE.get_size())

	status_bar_cache_dict[id] = sprite_3d
	add_child(sprite_3d)
	return sprite_3d


func register_id(id: int):
	var comps: Array[ECSComponent] = [
		ECSComponent.get_by_id(ComponentClientIdentifier, id),
		ECSComponent.get_by_id(ComponentHealth, id),
		ECSComponent.get_by_id(ComponentBoundingBox, id),
	]

	if comps.has(null):
		push_error("Cannot register id. Components found: " + str(comps))
		return

	else:
		status_bar_cache_dict[id] = create_status_bar(id)
		ids_registered_arr.append(id)


##TODO: Make this get called when a player's entity is added to the scene
func _on_client_entity_spawned(id: int):
	register_id(id)
