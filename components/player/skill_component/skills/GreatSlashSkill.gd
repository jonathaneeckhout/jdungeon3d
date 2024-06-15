class_name GreatSlashSkill
extends Skill

## Amount of minimum attack power that is added to the stats component value
@export var minimum_attack_power: float = 10.0
## Amount of maximum attack power that is added to the stats component value
@export var maximum_attack_power: float = 20.0


func _effect():
	if hit_box == null:
		return

	var areas = hit_box.get_overlapping_areas()
	for area in areas:
		var body = area.get_parent()

		# For now only allow to hit enemies
		if not body is Enemy:
			continue

		var health_component: HealthComponent = body.component_list.get_component("HealthComponent")
		if health_component == null or health_component.is_dead:
			continue

		var stats_component: StatsComponent = actor.component_list.get_component("StatsComponent")
		if stats_component == null:
			continue

		var total_min_ap: float = (
			minimum_attack_power + stats_component.get_stat_value("minimum_attack_power")
		)
		var total_max_ap: float = (
			maximum_attack_power + stats_component.get_stat_value("maximum_attack_power")
		)

		health_component.take_damage(randf_range(total_min_ap, total_max_ap))
