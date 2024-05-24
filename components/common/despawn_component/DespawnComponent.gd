class_name DespawnComponent
extends Component

signal despawned

@export var despawn_time: float = 10.0

var _health_component: HealthComponent = null
var _despawn_timer: Timer = null


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

	_health_component = get_node("../HealthComponent") as HealthComponent

	_health_component.died.connect(_on_died)
	_despawn_timer = Timer.new()
	_despawn_timer.name = "DespawnTimer"
	_despawn_timer.one_shot = true
	_despawn_timer.wait_time = despawn_time
	_despawn_timer.timeout.connect(_on_despawn_timer_timeout)
	add_child(_despawn_timer)


func _on_died():
	actor.collision_layer = 0
	actor.collision_mask = 0

	_despawn_timer.start()


func _on_despawn_timer_timeout():
	despawned.emit()

	actor.queue_free()
