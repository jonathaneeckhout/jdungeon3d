class_name BattlefieldMendingSkill
extends Skill

@export var minimum_heal_amount: float = 15.0
@export var maxmimum_heal_amount: float = 30.0


func _effect():
	var health_component: HealthComponent = actor.component_list.get_component("HealthComponent")
	if health_component == null or health_component.is_dead:
		return

	var heal_amount: float = randf_range(minimum_heal_amount, maxmimum_heal_amount)
	health_component.heal(heal_amount)
