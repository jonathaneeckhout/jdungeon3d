extends System
class_name SystemDamage
##

signal attack_ocurred(attacker_id: int, victim_id: int, amount: int)

## In the future, the function can take into account stats or other properties from the attacker to influence the attack.
func deal_damage(attacker_id: int, victim_id: int, amount: int):
	var victim_health: ComponentHealth = ComponentHealth.get_instance(victim_id)
	var current_health: float = victim_health.current
	victim_health.set_health( current_health - amount)
	
	attack_ocurred.emit(attacker_id, victim_id, amount)


func _physics_process(delta):
	for hitbox: ComponentHitbox in ComponentHitbox.get_all_instances():
		hitbox.get_area_3d()
