extends System
class_name CameraSystem

func _ready() -> void:
	for view_comp: ComponentView in Component.get_all(ComponentView):
		register_id(view_comp.get_id())


func _process(delta: float) -> void:
	pass
