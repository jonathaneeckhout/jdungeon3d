class_name StatsComponent
extends Component

var _stats: Dictionary = {
	"minimum_attack_power": 0.0, "maximum_attack_power": 0.0, "attack_speed": 0.0
}

var _stats_sources: Dictionary = {}


func register_stats(source: String, stats: Dictionary):
	#TODO: Check for nonexisting stats
	_stats_sources[source] = stats

	_calculate_stats()


func get_stat_value(stat: String) -> float:
	return _stats[stat]


func _reset_stats():
	for stat: String in _stats:
		_stats[stat] = 0.0


func _calculate_stats():
	# Reset all stats
	_reset_stats()

	for source: String in _stats_sources:
		var stats: Dictionary = _stats_sources[source]

		for stat: String in stats:
			_stats[stat] += stats[stat]
