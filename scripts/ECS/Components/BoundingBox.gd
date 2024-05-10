extends Component
class_name ComponentBoundingBox

@export var size: Vector3
@export var offset: Vector3

func get_aabb():
	return AABB(offset, size)


func get_top() -> Vector3:
	var ends: Vector3 = get_aabb().end
	ends.x /= 2
	ends.z /= 2
	return ends
	
