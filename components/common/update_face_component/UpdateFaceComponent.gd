class_name UpdateFaceComponent
extends Component


func _physics_process(_delta):
	if not actor.velocity.is_zero_approx():
		# The small plus Vector3(0.001, 0.0, 0.0) is to avoid the look_at function to sometimes fail
		actor.look_at(
			actor.velocity + actor.global_transform.origin + Vector3(0.001, 0.0, 0.0), Vector3.UP
		)
