extends Node3D

## The prefix used for every log line on the client
@export var client_logging_prefix: String = "Client"


func _ready():
	_start_client()


func _start_client() -> bool:
	GodotLogger._prefix = client_logging_prefix

	# Set the window's title
	get_window().title = "JDungeon3D (Client)"
	GodotLogger.info("Running as client")

	return true
