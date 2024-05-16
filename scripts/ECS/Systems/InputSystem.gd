extends System
class_name InputSystem

const ComponentActionDict: Dictionary = {
	"attack_1" : ComponentInput.Actions.ATTACK,
	"move_left" : ComponentInput.Actions.MOVE_LEFT,
	"move_right" : ComponentInput.Actions.MOVE_RIGHT,
	"move_up" : ComponentInput.Actions.MOVE_FORWARD,
	"move_down" : ComponentInput.Actions.MOVE_BACK,
	
}

func _unhandled_input(event: InputEvent):
	update_component_input_from_client(event)


func update_component_input_from_client(event: InputEvent):
	var clientside_input_comp: ComponentInput = get_client_input_comp()
	
	var action: ComponentInput.Actions
	var pressed: bool
	
	if event.is_action("attack_1"):
		action = ComponentActionDict["attack_1"] as ComponentInput.Actions
		pressed = event.is_pressed()
		
	elif event.is_action("move_left"):
		action = ComponentActionDict["move_left"] as ComponentInput.Actions
		pressed = event.is_pressed()
		
	elif event.is_action("move_right"):
		action = ComponentActionDict["move_right"] as ComponentInput.Actions
		pressed = event.is_pressed()
		
	elif event.is_action("move_down"):
		action = ComponentActionDict["move_down"] as ComponentInput.Actions
		pressed = event.is_pressed()
		
	elif event.is_action("move_up"):
		action = ComponentActionDict["move_up"] as ComponentInput.Actions
		pressed = event.is_pressed()
	
	clientside_input_comp.set_action_pressed(
		action, pressed
	)
	debug_msg(str(action) + ", pressed: " + str(pressed))
	
	var entity: Node3D = clientside_input_comp.get_parent()
	clientside_input_comp.set_targeted_direction(entity.rotation)
	
	
func get_client_input_comp() -> ComponentInput:
	var target_entity_id: int = Component.get_id_of_entity(
		ComponentClientIdentifier.get_client_entity()
		) 
	
	var current_input_comp: ComponentInput = Component.get_by_id(ComponentInput, target_entity_id)
	return current_input_comp
	

