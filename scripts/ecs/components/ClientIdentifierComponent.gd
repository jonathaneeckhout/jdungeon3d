extends Component
class_name ComponentClientIdentifier

static var client_entity: Node = null

@export var client_id: int


func _ready():
	if client_entity == null:
		set_own_entity_as_client()


func set_client_id(multiplayer_id: int):
	client_id = multiplayer_id


func get_client_id() -> int:
	return client_id


func set_own_entity_as_client():
	ComponentClientIdentifier.set_client_entity(get_parent())


static func set_client_entity(entity: Node):
	ComponentClientIdentifier.client_entity = entity


static func get_client_entity() -> Node:
	return ComponentClientIdentifier.client_entity
