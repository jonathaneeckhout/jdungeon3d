class_name CombatComponent
extends Component

signal attacking

@export var attack_power: float = 10.0
@export var attack_speed: float = 1.0
@export var hit_box: Area3D = null

var _attack_timer: Timer = null
var _attack_pressed: bool = false


func _ready():
	super._ready()

	_attack_timer = Timer.new()
	_attack_timer.one_shot = true
	_attack_timer.name = "AttackTimer"
	add_child(_attack_timer)


func _input(event):
	if event.is_action_pressed("standard_attack"):
		_attack_pressed = true


func _physics_process(_delta):
	if _attack_pressed and _attack_timer.is_stopped():
		_attack_timer.start(attack_speed)
		_attack_pressed = false

		# Attack logic here
		attacking.emit()

		# Check for hit
		if hit_box != null:
			var areas = hit_box.get_overlapping_areas()
			for area in areas:
				var body = area.get_parent()
				if body is Enemy:
					var health_component: HealthComponent = body.componnt_list.get_component(
						"HealthComponent"
					)
					if health_component != null:
						health_component.take_damage(attack_power)
