extends VBoxContainer

@export var health_component: HealthComponent = null

@onready var _health_bar: ProgressBar = %HealthBar
@onready var _energy_bar: ProgressBar = %EnergyBar


func _ready():
	health_component.health_changed.connect(_on_health_changed)

	_update_health_bar()

	#TODO: implement energy system
	_energy_bar.max_value = 100
	_energy_bar.value = 100


func _update_health_bar():
	_health_bar.max_value = health_component.maximum
	_health_bar.value = health_component.health


func _on_health_changed(_change_amount: float):
	_update_health_bar()
