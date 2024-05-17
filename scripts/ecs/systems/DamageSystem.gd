extends System
class_name SystemDamage
## Checks which Hitbox components are touching which Hurtbox components, then deals damage to their Health component.

signal attack_ocurred(attacker_id: int, victim_id: int, amount: int)

var hurtbox_timer_dict: Dictionary

func _tick():
	## Progress invulnerability timers
	for id: int in hurtbox_timer_dict.keys():
		var curr_time: float = get_hurtbox_current_invul_timer(id)
		hurtbox_timer_dict[id] = curr_time - time_per_tick
		
		if curr_time <= 0:
			hurtbox_timer_dict.erase(id)
		
	## Check all hitboxes
	for hitbox: ComponentHitbox in Component.get_all(ComponentHitbox):
		
		if not hitbox.is_enabled():
			continue
		
		## Skip if it is spent
		if hitbox.get_hit_limit() <= 0:
			hitbox.set_enabled(false)
			continue

		var area: Area3D = hitbox.get_area_3d()
		
		## Get the attacker's id
		var attacker_id: int = hitbox.get_id()
		var overlaps: Array[Area3D] = area.get_overlapping_areas()
		
		## Check their collisions
		for overlapping_area: Area3D in overlaps:
			
			## If the area that collided does not have an associated hurtbox, skip.
			var hurtbox: ComponentHurtbox = ComponentHurtbox.get_hurtbox_of_area(overlapping_area)
			if hurtbox == null:
				continue
			
			## Finally get the id of the victim
			var victim_id: int = hurtbox.get_id()
			
			## Do not hit self if set to ignore self
			if hitbox.ignore_self_entity and victim_id == attacker_id:
				continue
				
			## If the invulnerability timer is considered and still running, skip
			if hitbox.ignore_invulnerability or get_hurtbox_current_invul_timer(victim_id) > 0:
				continue
				
			deal_damage(attacker_id, victim_id, hitbox.damage)
			start_hurtbox_invul_timer(victim_id)
			hitbox.change_hit_limit( - 1)
			
			debug_msg("Entity {0} hit entity {1} for {2} damage".format(
				[str(attacker_id), str(victim_id), str(hitbox.damage)])
				)
			debug_msg(str(instance_from_id(attacker_id)) + "\n" + str(instance_from_id(victim_id)))

## In the future, the function could take into account stats or other properties from the attacker to influence the attack.
func deal_damage(attacker_id: int, victim_id: int, amount: int):
	var victim_health: ComponentHealth = Component.get_by_id(ComponentHealth, victim_id)
	
	## Do not deal damage if the target does not have health.
	if victim_health == null:
		return
		
	var current_health: float = victim_health.current
	victim_health.set_health(current_health - amount)
	debug_msg("Damaged for " + str(amount))
	
	attack_ocurred.emit(attacker_id, victim_id, amount)

func start_hurtbox_invul_timer(component_id: int):
	var hurtbox := Component.get_by_id(ComponentHurtbox, component_id)
	if hurtbox == null:
		return
	hurtbox_timer_dict[component_id] = hurtbox.invul_time

func get_hurtbox_current_invul_timer(component_id: int) -> float:
	return hurtbox_timer_dict.get(component_id, 0)
