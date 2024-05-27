class_name Skill
extends Node

signal skill_casting
signal skill_casted
signal skill_recharged

## The name/class of the skill
@export var skill_class: String = ""

## The desciption of the skill
@export var description: String = ""

@export var cast_time: float = 1.0
@export var timeout: float = 10.0

var _cast_timer: Timer = null
var _timeout_timer: Timer = null


func _ready():
	_cast_timer = Timer.new()
	_cast_timer.one_shot = true
	_cast_timer.name = "CastTimer"
	_cast_timer.timeout.connect(_on_cast_timer_timeout)
	add_child(_cast_timer)

	_timeout_timer = Timer.new()
	_timeout_timer.one_shot = true
	_timeout_timer.name = "TimeoutTimer"
	_timeout_timer.timeout.connect(_on_timeout_timer_timeout)
	add_child(_timeout_timer)


func use() -> bool:
	if not _cast_timer.is_stopped() or not _timeout_timer.is_stopped():
		return false

	GodotLogger.info("Using skill: %s" % skill_class)

	_cast_timer.start(cast_time)

	skill_casting.emit()

	return true


func _effect():
	pass


func _on_cast_timer_timeout():
	_effect()

	_timeout_timer.start(timeout)

	skill_casted.emit()


func _on_timeout_timer_timeout():
	skill_recharged.emit()
