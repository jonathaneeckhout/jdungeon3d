extends System
class_name FloatingStatusSystem

const COLOR_GOOD := Color.LAWN_GREEN
const COLOR_BAD := Color.RED

func _ready():
	super._ready()
	
	for client: ComponentClientIdentifier in Component.get_all(ComponentClientIdentifier):
		register_id(client.get_id())


func _tick():
	for id: int in registered_ids:
		var health_comp: ComponentHealth = Component.get_by_id(ComponentHealth, id)
		var ui_ref_comp: ComponentUIReference = Component.get_by_id(ComponentUIReference, id)
		
		var entity_pos: Vector3 = health_comp.get_parent().global_position
		var status_bar: Sprite3D = ui_ref_comp.get_ref_floating_health_bar()
		
		var status_percent: float = health_comp.get_health() / health_comp.get_max_health()
		
		status_bar.modulate = COLOR_BAD.lerp(COLOR_GOOD, status_percent)
		status_bar.region_rect.size.x = status_bar.texture.get_width() * status_percent


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
		super.register_id(id)


##TODO: Make this get called when a player's entity is added to the scene
func _on_client_entity_spawned(id: int):
	register_id(id)
