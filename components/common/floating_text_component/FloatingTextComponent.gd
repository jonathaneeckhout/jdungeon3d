class_name FloatingTextComponent
extends Component

@export var text_height: float = -64.0

var _floating_text_scene = preload("res://scenes/ui/floating_text/FloatingText.tscn")

var _health_component: HealthComponent = null


func _ready():
	super._ready()

	_health_component = get_node("../HealthComponent") as HealthComponent

	_health_component.healed.connect(_on_healed)
	_health_component.hurt.connect(_on_hurt)


func _on_hurt(amount: int):
	var text = _floating_text_scene.instantiate()
	text.height = text_height
	text.amount = amount
	text.type = text.TYPES.DAMAGE
	add_child(text)


func _on_healed(amount: int):
	var text = _floating_text_scene.instantiate()
	text.height = text_height
	text.amount = amount
	text.type = text.TYPES.HEALING
	add_child(text)
