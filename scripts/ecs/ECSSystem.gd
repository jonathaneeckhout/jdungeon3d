extends Node3D
class_name ECSSystem
## Systems essentially act as singletons. They perform actions by looking for the appropiate components on a given entity.

@export var debug_mode: bool = false
@export var time_per_tick: float = 1.0 / 60.0


func _ready() -> void:
	## Do not start a timer if this is 0 or lower.
	if time_per_tick <= 0:
		return

	var timer := Timer.new()
	add_child(timer)
	timer.process_callback = Timer.TIMER_PROCESS_PHYSICS
	timer.timeout.connect(tick)
	timer.start(time_per_tick)


func tick():
	_tick()


func _tick():
	pass


func debug_msg(variant: Variant):
	if not debug_mode:
		return
	print_debug(variant)
