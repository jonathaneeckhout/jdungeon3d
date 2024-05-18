extends Component
class_name ComponentClientIdentifier

static var client_entity_id: int

@export var client_id: int

func _ready():
	if client_entity_id == 0:
		set_own_entity_id_as_client()

func set_client_id(multiplayer_id: int):
	client_id = multiplayer_id

func get_client_id() -> int:
	return client_id

func set_own_entity_id_as_client():
	var entity: Node = get_parent()
	var id: int = Component.get_id_of_entity(entity)
	ComponentClientIdentifier.set_client_entity_id(id)

static func set_client_entity_id(id: int):
	ComponentClientIdentifier.client_entity_id = id

static func get_client_entity_id() -> int:
	return ComponentClientIdentifier.client_entity_id
