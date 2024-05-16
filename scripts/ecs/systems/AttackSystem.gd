extends System
class_name AttackSystem

var registered_ids: Array[int]

var attack_timer_dict: Dictionary

func _ready():
	super._ready()
	
	for comp: ComponentClientIdentifier in Component.get_all(ComponentClientIdentifier):
		registered_ids.append(comp.get_id())

func _tick():
	for id: int in attack_timer_dict.keys():
		var new_time: float = attack_timer_dict.get(id, 0.0) - time_per_tick
		attack_timer_dict[id] = new_time
		
		if new_time < 0:
			attack_timer_dict.erase(id)
	
	for entity_id: int in registered_ids:
		var input_comp: ComponentInput = Component.get_by_id(ComponentInput, entity_id)
		var hitbox_comp: ComponentHitbox = Component.get_by_id(ComponentHitbox, entity_id)
		var attack_comp: ComponentAttack = Component.get_by_id(ComponentAttack, entity_id)
		
		## Any previous attack must have ended
		if attack_timer_dict.get(entity_id, 0.0) > 0:
			continue
		
		##If the previous attack did end, deactivate the hitbox
		else:
			hitbox_comp.set_enabled(false)
		
		## Attack input must be true
		if not input_comp.is_action_pressed(input_comp.Actions.ATTACK):
			continue
			
		attack_timer_dict[entity_id] = attack_comp.attack_duration
		hitbox_comp.set_enabled(true)
		debug_msg("Attack preformed")
			
		
