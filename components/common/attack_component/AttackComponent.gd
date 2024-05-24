class_name AttackComponent
extends Component

signal attacking

@export var minimum_attack_power: float = 5.0
@export var maximum_attack_power: float = 10.0

@export var attack_speed: float = 1.0
## The delay between the attack button being pressed and the attack actually happening
@export var attack_delay: float = 0.5


func get_attack_power() -> float:
	return randf_range(minimum_attack_power, maximum_attack_power)
 
