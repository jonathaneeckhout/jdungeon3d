extends Component
class_name ComponentBoundingBox

@export var size: Vector3
@export var offset: Vector3


func get_aabb():
	return AABB(offset, size)


func get_top() -> Vector3:
	var output := Vector3(0, size.y, 0)
	return output


func get_center() -> Vector3:
	var output := Vector3(0, size.y / 2, 0)
	return output


func get_front() -> Vector3:
	var output := get_center() + Vector3.FORWARD * size.z / 2
	return output
