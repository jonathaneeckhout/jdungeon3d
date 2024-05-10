extends Component
class_name ComponentBoundingBox

@export var size: Vector3
@export var offset: Vector3

func get_aabb():
	return AABB(offset, size)


func get_top() -> Vector3:
	var output: Vector3 = get_aabb().size
	output.x = output.x / 2
	output.z = output.z / 2
	return output + offset

