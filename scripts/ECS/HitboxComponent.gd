extends Component
class_name ComponentHitbox

static var area_to_hitbox_dict: Dictionary

@export var damage: float = 0
@export var area_node: Area3D

func _ready() -> void:
	if not is_area_valid(get_area_3d()):
		push_error("No area found.")
		return 
		
	area_to_hitbox_dict[get_area_3d()] = self

	
static func get_hitbox_of_area(area: Area3D) -> ComponentHitbox:
	return area_to_hitbox_dict.get(area, null)


func get_area_3d() -> Area3D:
	return area_node


func is_area_valid(area: Area3D) -> bool:
	if not area is Area3D:
		push_error("Area3D not set.")
		return false
		
	if area.collision_mask == 0:
		push_warning("An area without a mask won't work for a hitbox.")
	
	if area.collision_layer != 0:
		push_warning("An area for a hitbox does not need to be on a layer.")
	
	return true
