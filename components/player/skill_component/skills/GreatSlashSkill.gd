class_name GreatSlashSkill
extends Skill

@export var minimum_attack_power: float = 10.0
@export var maximum_attack_power: float = 20.0


func _effect():
	GodotLogger.info("!Using great slash")
	if hit_box == null:
		return

	var areas = hit_box.get_overlapping_areas()
	for area in areas:
		var body = area.get_parent()
		if body is Enemy:
			var health_component: HealthComponent = body.component_list.get_component(
				"HealthComponent"
			)
			if health_component != null and not health_component.is_dead:
				health_component.take_damage(get_attack_power())


func get_attack_power() -> float:
	return randf_range(minimum_attack_power, maximum_attack_power)
