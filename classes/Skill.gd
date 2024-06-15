class_name Skill
extends Node

signal skill_casting
signal skill_casted
signal skill_recharged

## The name/class of the skill
@export var skill_class: String = ""

## The desciption of the skill
@export var description: String = ""

## The time it takes to cast the complete skill
@export var cast_time: float = 1.0
## The time it takes to perform the actual hit
@export var hit_time: float = 1.0
## The time before this skill can be used again
@export var timeout: float = 10.0

var actor: Node3D = null
var hit_box: Area3D = null

var _cast_timer: Timer = null
var _hit_timer: Timer = null
var _timeout_timer: Timer = null


func _ready():
	_cast_timer = Timer.new()
	_cast_timer.one_shot = true
	_cast_timer.name = "CastTimer"
	_cast_timer.timeout.connect(_on_cast_timer_timeout)
	add_child(_cast_timer)

	_hit_timer = Timer.new()
	_hit_timer.one_shot = true
	_hit_timer.name = "HitTimer"
	_hit_timer.timeout.connect(_on_hit_timer_timeout)
	add_child(_hit_timer)

	_timeout_timer = Timer.new()
	_timeout_timer.one_shot = true
	_timeout_timer.name = "TimeoutTimer"
	_timeout_timer.timeout.connect(_on_timeout_timer_timeout)
	add_child(_timeout_timer)


func use() -> bool:
	if not _cast_timer.is_stopped() or not _timeout_timer.is_stopped():
		return false

	GodotLogger.info("Using skill: %s" % skill_class)

	_hit_timer.start(hit_time)
	_cast_timer.start(cast_time)
	_timeout_timer.start(timeout)

	skill_casting.emit()

	return true


func is_ready() -> bool:
	return _timeout_timer.is_stopped()


func get_timeout_timer_timeleft() -> float:
	return _timeout_timer.time_left


func _effect():
	pass


func _on_cast_timer_timeout():
	skill_casted.emit()


func _on_hit_timer_timeout():
	_effect()


func _on_timeout_timer_timeout():
	skill_recharged.emit()
