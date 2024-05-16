extends System
class_name MovementSystem

var registered_ids: Array[int]
var uses_physics_dict: Dictionary


func _ready():
	super._ready()
	
	for client_comp: ComponentClientIdentifier in Component.get_all(ComponentClientIdentifier):
		register_id(client_comp.get_id())

#func _tick():
	#pass
	
	
func _physics_process(delta: float):
	for entity_id: int in registered_ids:
		##Ensure it can move
		var move_comp: ComponentMovement = Component.get_by_id(ComponentMovement, entity_id)
		if not move_comp.is_enabled():
			continue
		
		## Get movement direction	
		var input_comp: ComponentInput = Component.get_by_id(ComponentInput, entity_id)
		move_comp.set_movement_vector(get_move_vector_from_input(input_comp))
		var movement_vec: Vector3 = move_comp.get_movement_vector() * move_comp.get_base_speed() * delta
		
		## Get rotation
		var facing_comp: ComponentFacing = Component.get_by_id(ComponentFacing, entity_id)
		var entity_rotation: Vector3 = facing_comp.get_entity_rotation_euler()
		movement_vec.rotated(Vector3.UP, entity_rotation.y)
		movement_vec.rotated(Vector3.RIGHT, entity_rotation.x)
		movement_vec.rotated(Vector3.FORWARD, entity_rotation.z)
		
		var entity: Node = move_comp.get_parent()
		if is_physics_user(entity_id):
			assert(entity is PhysicsBody3D)
			entity.velocity = movement_vec
			entity.look_at(entity.position + entity.velocity)
			entity.move_and_slide()
		else:
			entity.position += movement_vec
	
func is_physics_user(id: int) -> bool:
	return uses_physics_dict.get(id, false)
	
	
func get_move_vector_from_input(input_comp: ComponentInput) -> Vector3:
	var output: Vector3
	if input_comp.is_action_pressed(input_comp.Actions.MOVE_RIGHT):
		output += Vector3.RIGHT
	if input_comp.is_action_pressed(input_comp.Actions.MOVE_LEFT):
		output += Vector3.LEFT
	if input_comp.is_action_pressed(input_comp.Actions.MOVE_FORWARD):
		output += Vector3.FORWARD
	if input_comp.is_action_pressed(input_comp.Actions.MOVE_BACK):
		output += Vector3.BACK
	return output
	
	
func register_id(id: int):
	registered_ids.append(id)
	
	var entity: Node = Component.get_by_id(ComponentMovement, id)
	if entity is PhysicsBody3D:
		uses_physics_dict[id] = true
	else:
		uses_physics_dict[id] = false
