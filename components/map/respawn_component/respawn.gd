class_name Respawn
extends Node

@export var group_node: Node3D = null
@export var entity_scene: PackedScene = null
@export var entity_name: String = ""
@export var entity_position: Vector3 = Vector3.ZERO
@export var respawn_time: float = 10.0

var _respawn_timer: Timer = null


func _ready():
	_respawn_timer = Timer.new()
	_respawn_timer.name = "DespawnTimer"
	_respawn_timer.one_shot = true
	_respawn_timer.autostart = true
	_respawn_timer.wait_time = respawn_time
	_respawn_timer.timeout.connect(_on_despawn_timer_timeout)
	add_child(_respawn_timer)


func _on_despawn_timer_timeout():
	var entity: Node3D = entity_scene.instantiate()
	entity.name = entity_name
	entity.position = entity_position
	group_node.add_child(entity)

	queue_free()
