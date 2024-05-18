extends System
class_name MovementSystem

const DEFAULT_GRAVITY := Vector3.DOWN * 7

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
		
		## Get movement direction input	
		var input_comp: ComponentInput = Component.get_by_id(ComponentInput, entity_id)
		move_comp.set_movement_vector(get_move_vector_from_input(input_comp))
		var input_move_vector: Vector3 = move_comp.get_movement_vector() * move_comp.get_base_speed() * delta
		
		## Get camera direction
		var view_comp: ComponentView = Component.get_by_id(ComponentView, entity_id)
		var view_rotation: Vector3 = view_comp.get_view_rotation()
		
		## Update the facing to use input + camera direction, do not account for side tilt
		var faced_movement_vector: Vector3 = input_move_vector.rotated(Vector3.UP, view_rotation.y)
		
		## If the facing changed, update the model's facing
		if faced_movement_vector != Vector3.ZERO:
			move_comp.model_node_reference.look_at( view_comp.get_parent().global_position + faced_movement_vector, Vector3.UP, true )
		
		## Get gravity, if any
		var grav_comp: ComponentGravity = Component.get_by_id(ComponentGravity, entity_id)
		var gravity: Vector3
		if grav_comp:
			if grav_comp.gravity_override != grav_comp.NO_OVERRIDE:
				gravity = grav_comp.gravity_override * grav_comp.weight
			else:
				gravity = DEFAULT_GRAVITY * grav_comp.weight
			
		
		## Apply movement
		var entity: Node = move_comp.get_parent()
		## Move CharacterBody3D
		if is_character_body(entity_id):
			assert(entity is PhysicsBody3D)
			entity.velocity = faced_movement_vector + gravity
			entity.move_and_slide()
			
			## Update on floor state
			move_comp.set_on_floor(entity.is_on_floor())
			
		## Move non-physics object
		else:
			entity.position += faced_movement_vector + gravity
			
			## Update on floor state
			var ray_param := PhysicsRayQueryParameters3D.create(
				entity.global_position, 
				## The vector accounts for velocity but it can only go down
				Vector3.DOWN * clamp((faced_movement_vector + gravity).y, -INF, 0)
				)
			if not get_world_3d().direct_space_state.intersect_ray(ray_param).is_empty():
				move_comp.set_on_floor(true)
			else: 
				move_comp.set_on_floor(false)
	
func is_character_body(id: int) -> bool:
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
	super.register_id(id)
	
	var entity: Node = Component.get_by_id(ComponentMovement, id).get_parent()
	if entity is CharacterBody3D:
		uses_physics_dict[id] = true
	else:
		uses_physics_dict[id] = false
