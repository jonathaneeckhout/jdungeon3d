extends Component
class_name ComponentFacing

#@export var rotation_angle_limit: Vector3 = Vector3(TAU,TAU,TAU)
var facing_direction: Vector3

func set_facing_direction(val: Vector3):
	
	facing_direction = val
	
	
func get_facing_direction() -> Vector3:
	return facing_direction


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
