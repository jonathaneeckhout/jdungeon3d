extends Component
class_name ComponentHitbox

@export var damage: float
@export var area_node: Area3D

func _ready():
	super._ready()
	
	var area: Area3D = get_area_3d()
	
	#Check if it has the correct parent
	if not area is Area3D:
		push_error("Area3D not set.")
		
	if area.collision_mask == 0:
		push_warning("An area without a mask won't work for a hitbox.")
	
	if area.collision_layer != 0:
		push_warning("A hitbox shouldn't need to be on a layer.")		
		
		

func get_area_3d() -> Area3D:
	return area_node
	
	
func get_():
	pass
