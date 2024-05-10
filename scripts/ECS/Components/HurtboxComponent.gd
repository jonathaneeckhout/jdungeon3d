extends Component
class_name ComponentHurtbox

static var area_to_hurtbox_dict: Dictionary

@export var invul_time: float = 0.2
@export var area_node: Area3D

func _ready() -> void:
	if not is_area_valid(get_area_3d()):
		push_error("No area found.")
		return 
		
	area_to_hurtbox_dict[get_area_3d()] = self

	
static func get_hurtbox_of_area(area: Area3D) -> ComponentHurtbox:
	return area_to_hurtbox_dict.get(area, null)
	

func get_area_3d() -> Area3D:
	return area_node
	
	
func get_():
	pass


func is_area_valid(area: Area3D) -> bool:
	if not area is Area3D:
		push_error("Area3D not set.")
		return false
		
	
	if area.collision_layer == 0:
		push_warning("An area without a layer won't work for a hurtbox.")
		
		
	if area.collision_mask != 0:
		push_warning("An area for a hurtbox does not need to be on a layer.")
		
	
	return true
