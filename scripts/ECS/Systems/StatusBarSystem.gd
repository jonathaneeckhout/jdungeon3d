extends System
class_name SatusBarSystem

const COLOR_GOOD := Color.LAWN_GREEN
const COLOR_BAD := Color.RED

var status_bar_cache_dict: Dictionary = {}
var ids_registered_arr: Array[int]


func _ready():
	super._ready()
	
	for client: ComponentClientIdentifier in Component.get_all(ComponentClientIdentifier):
		register_id(client.get_id())


func _tick():
	for id: int in ids_registered_arr:
		var bounding_box_comp: ComponentBoundingBox = Component.get_by_id(ComponentBoundingBox, id)
		var health_comp: ComponentHealth = Component.get_by_id(ComponentHealth, id)
		var entity_pos: Vector3 = health_comp.get_parent().global_position
		
		if not bounding_box_comp or not health_comp:
			push_warning("Missing components for entity {0}".format([str(id)]))
			continue
			
		var status_bar: Sprite3D = status_bar_cache_dict.get(id, null)
		
		var status_percent: float = health_comp.get_health() / health_comp.get_max_health()
		var status_pos: Vector3 = bounding_box_comp.get_top()
		
		status_bar.global_position = entity_pos
		status_bar.modulate = COLOR_BAD.lerp(COLOR_GOOD, status_percent)
		
			
	


func create_status_bar(id: int) -> Sprite3D:
	var sprite_3d := Sprite3D.new()
	sprite_3d.centered = true
	sprite_3d.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	sprite_3d.texture = preload("res://icon.svg")
	status_bar_cache_dict[id] = sprite_3d
	add_child(sprite_3d)
	return sprite_3d

func register_id(id: int):
	var comps: Array[Component] = [
		Component.get_by_id(ComponentClientIdentifier, id),
		Component.get_by_id(ComponentHealth, id),
		Component.get_by_id(ComponentBoundingBox, id),
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
