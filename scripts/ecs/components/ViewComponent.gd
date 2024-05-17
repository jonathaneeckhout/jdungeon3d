extends Component
class_name ComponentView

@export var camera_node: Camera3D

func set_view_rotation(val: Vector3):
	camera_node.rotation = val
	
	
func get_view_rotation() -> Vector3:
	return camera_node.rotation


func get_rotation_to_face(target_pos: Vector3, global: bool = false):
	var entity: Node3D = get_parent()
	var basis_rotation: Vector3
	var target_rotation: Vector3
	if global:
		basis_rotation = entity.global_transform.basis.get_euler()
		target_rotation = entity.global_transform.basis.looking_at(target_pos).get_euler()
	else:
		basis_rotation = entity.transform.basis.get_euler()
		target_rotation = entity.transform.basis.looking_at(target_pos).get_euler()
	return basis_rotation - target_rotation
	
	
func get_entity_rotation_euler(global: bool = false) -> Vector3:
	var entity: Node3D = get_parent()
	if global:
		return entity.global_rotation
	else:
		return entity.rotation
