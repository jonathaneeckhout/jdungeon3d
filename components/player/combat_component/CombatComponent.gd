class_name CombatComponent
extends Component

var _attack_pressed: bool = false

var _attack_component: AttackComponent = null


func _ready():
	super._ready()

	_attack_component = get_node("../AttackComponent") as AttackComponent


func _input(event):
	if event.is_action_pressed("standard_attack"):
		_attack_pressed = true


func _physics_process(_delta):
	if _attack_pressed:
		_attack_pressed = false

		_attack_component.attack()
