extends System
class_name GravitySystem

@export var global_gravity: Vector3 = Vector3.DOWN * 5

func _physics_process(delta: float):
	for comp_weight: ComponentWeight in Component.get_all(ComponentWeight):
		var entity: Node3D = comp_weight.get_parent()
		
		var gravity: Vector3
		if comp_weight.gravity_override == comp_weight.NO_OVERRIDE:
			gravity = global_gravity
		else:
			gravity = comp_weight.gravity_override
			
		if entity is CharacterBody3D:
			entity.velocity += gravity * comp_weight.mass * delta
			entity.move_and_slide()
		else:
			entity.position += gravity * comp_weight.mass * delta

