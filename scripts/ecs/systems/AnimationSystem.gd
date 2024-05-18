extends System
class_name AnimationSystem


func _ready() -> void:
	super._ready()
	
	for anim_comp: ComponentAnimation in Component.get_all(ComponentAnimation):
		register_id(anim_comp.get_id())


func _tick():
	for entity_id: int in registered_ids:
		var anim_comp: ComponentAnimation = Component.get_by_id(ComponentAnimation, entity_id)		
		var move_comp: ComponentMovement = Component.get_by_id(ComponentMovement, entity_id)
		
		if not move_comp.get_movement_vector().is_zero_approx() and move_comp.is_on_floor():
			anim_comp.get_animation_node().play(anim_comp.anim_name_move)
			
		elif move_comp.is_on_floor():
			anim_comp.get_animation_node().play(anim_comp.anim_name_idle)			
	
	
