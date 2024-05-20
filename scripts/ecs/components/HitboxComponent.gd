extends ECSComponent
class_name ComponentHitbox
## Designed to work with an Area3D that only finds others but can't be found. It then deals the specified damage.

const HIT_LIMIT_UPPER_BOUND: int = pow(2, 62)

static var area_to_hitbox_dict: Dictionary

@export var area_node: Area3D
@export var enabled: bool = true
@export var damage: float = 0
@export_category("Setting")
@export var hit_limit_max: int = 1
@export var ignore_invulnerability: bool = false
@export var ignore_self_entity: bool = true
@export var refresh_limit_on_enable: bool = true

var hit_limit: int = 1


func _ready() -> void:
	if not is_area_valid(get_area_3d()):
		push_error("No area found.")
		return

	area_to_hitbox_dict[get_area_3d()] = self
	hit_limit = hit_limit_max


static func get_hitbox_of_area(area: Area3D) -> ComponentHitbox:
	return area_to_hitbox_dict.get(area, null)


func get_area_3d() -> Area3D:
	return area_node


func is_area_valid(area: Area3D) -> bool:
	if not area is Area3D:
		push_error("Area3D not set.")
		return false

	if area.collision_mask == 0:
		push_warning("An Area3D without a mask won't work for a hitbox.")

	if area.collision_layer != 0:
		push_warning("An Area3D for a hitbox does not need to be on a layer.")

	return true


func set_hit_limit(val: int):
	hit_limit = clamp(val, 0, hit_limit_max)


func change_hit_limit(amount: int):
	var current: int = hit_limit
	set_hit_limit(current + amount)


func get_hit_limit() -> int:
	return hit_limit


func set_enabled(val: bool):
	enabled = val
	if enabled and refresh_limit_on_enable:
		set_hit_limit(hit_limit_max)


func is_enabled() -> bool:
	return enabled
