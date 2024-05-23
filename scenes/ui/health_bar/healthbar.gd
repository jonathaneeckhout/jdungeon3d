extends Sprite3D

const GREEN_BAR: Resource = preload("res://assets/ui/healthbar/scaled/GreenBar.png")
const YELLOW_BAR: Resource = preload("res://assets/ui/healthbar/scaled/YellowBar.png")
const RED_BAR: Resource = preload("res://assets/ui/healthbar/scaled/RedBar.png")

@export var _health_component: HealthComponent = null

var _actor: Node3D = null

@onready var progress_bar: TextureProgressBar = $SubViewport/ProgressBar


func _ready():
	_actor = get_parent()
	%Actor.text = _actor.name

	_health_component.health_changed.connect(_on_health_changed)


func update(amount, full):
	progress_bar.texture_progress = GREEN_BAR
	if amount < 0.75 * full:
		progress_bar.texture_progress = YELLOW_BAR
	if amount < 0.45 * full:
		progress_bar.texture_progress = RED_BAR
	progress_bar.value = amount


func _on_health_changed(_change_amount: float):
	update(_health_component.health, _health_component.maximum)
