class_name BaseStatsComponent
extends Component

@export var minimum_attack_power: float = 5.0
@export var maximum_attack_power: float = 10.0
@export var attack_speed: float = 1.0

var _stats_component: StatsComponent = null


func _ready():
	super._ready()

	_stats_component = get_node_or_null("../StatsComponent")

	_stats_component.register_stats(
		"BaseStats",
		{
			"minimum_attack_power": minimum_attack_power,
			"maximum_attack_power": maximum_attack_power,
			"attack_speed": attack_speed
		}
	)
