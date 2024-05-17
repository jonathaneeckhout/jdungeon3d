extends System
class_name InputSystem

const ComponentActionDict: Dictionary = {
	&"attack_1": ComponentInput.Actions.ATTACK,
	&"move_left": ComponentInput.Actions.MOVE_LEFT,
	&"move_right": ComponentInput.Actions.MOVE_RIGHT,
	&"move_up": ComponentInput.Actions.MOVE_FORWARD,
	&"move_down": ComponentInput.Actions.MOVE_BACK,
}

func _unhandled_input(event: InputEvent):
	update_component_input_from_client(event)

func update_component_input_from_client(event: InputEvent):
	var clientside_input_comp: ComponentInput = get_client_input_comp()
	##Cancel if there's no client to provide inputs
	if not clientside_input_comp:
		return
	
	var action: ComponentInput.Actions
	var pressed: bool
	
	## Check if the event is from a valid action
	for action_to_check: StringName in ComponentActionDict.keys():
		if event.is_action(action_to_check):
			action = ComponentActionDict[action_to_check]
			pressed = event.is_pressed()
			break
	
	## Set in the input component the state of the action
	clientside_input_comp.set_action_pressed(
		action, pressed
	)
	debug_msg(str(action) + ", pressed: " + str(pressed))
	
	var entity: Node3D = clientside_input_comp.get_parent()
	clientside_input_comp.set_targeted_direction(entity.rotation)

func get_client_input_comp() -> ComponentInput:
	var client_entity: Node = ComponentClientIdentifier.get_client_entity()
	if not client_entity:
		return null
		
	var target_entity_id: int = Component.get_id_of_entity(
		ComponentClientIdentifier.get_client_entity()
		)
	
	var current_input_comp: ComponentInput = Component.get_by_id(ComponentInput, target_entity_id)
	return current_input_comp
