extends ECSSystem
class_name InputSystem

const ComponentActionDict: Dictionary = {"attack_1": ComponentInput.Actions.ATTACK}


func _unhandled_input(event: InputEvent):
	update_component_input_from_client(event)


func update_component_input_from_client(event: InputEvent):
	var clientside_input_comp: ComponentInput = get_client_input_comp()

	var action: ComponentInput.Actions
	var pressed: bool

	if event.is_action_pressed("attack_1"):
		action = ComponentActionDict["attack_1"]
		pressed = true
	elif event.is_action_released("attack_1"):
		action = ComponentActionDict["attack_1"]
		pressed = false

	clientside_input_comp.set_action_pressed(action, pressed)
	debug_msg(str(action) + ", pressed: " + str(pressed))

	var entity: Node3D = clientside_input_comp.get_parent()
	clientside_input_comp.set_targeted_direction(entity.rotation)


func get_client_input_comp() -> ComponentInput:
	var target_entity_id: int = ECSComponent.get_id_of_entity(
		ComponentClientIdentifier.get_client_entity()
	)

	var current_input_comp: ComponentInput = ECSComponent.get_by_id(ComponentInput, target_entity_id)
	return current_input_comp
