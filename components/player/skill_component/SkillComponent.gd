class_name SkillComponent
extends Component

@export var skills: Array[PackedScene] = [null, null, null, null]

var is_using_skill: bool = false
var current_skill: Skill = null

var _skill_pressed: int = -1

# Group node containing all skills from the actor
var _skills: Node = null

var _skill_mapper: Dictionary = {}

var _attack_component: AttackComponent = null


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

	_attack_component = get_node("../AttackComponent")

	_skills = Node.new()
	_skills.name = "Skills"
	add_child(_skills)

	_load_skills()


func _input(event):
	if event.is_action_pressed("skill_0"):
		_skill_pressed = 0
	elif event.is_action_pressed("skill_1"):
		_skill_pressed = 1
	elif event.is_action_pressed("skill_2"):
		_skill_pressed = 2
	elif event.is_action_pressed("skill_3"):
		_skill_pressed = 3


func _physics_process(_delta: float):
	if _skill_pressed <= -1:
		return

	if skills.size() < _skill_pressed + 1:
		return

	# Can't cast a skill while you're already attacking
	if _attack_component.is_attacking:
		return

	GodotLogger.info("Using skill nr %d" % _skill_pressed)

	use_skill(_skill_pressed)

	# Reset the input
	_reset_input()


func _reset_input():
	_skill_pressed = -1


func _load_skills():
	# First clear all the skills
	for skill: Skill in _skills.get_children():
		skill.queue_free()

	_skill_mapper = {}

	var i: int = 0

	for skill_scene: PackedScene in skills:
		if skill_scene == null:
			continue

		var skill: Skill = skill_scene.instantiate()
		skill.name = skill.skill_class
		_skills.add_child(skill)

		_skill_mapper = {i: skill}
		i += 1


func use_skill(slot: int) -> bool:
	if not _skill_mapper.has(slot):
		return false

	if is_using_skill:
		return false

	if current_skill != null and current_skill.skill_casted.is_connected(_on_skill_casted):
		current_skill.skill_casted.disconnect(_on_skill_casted)

	current_skill = _skill_mapper[slot]

	is_using_skill = current_skill.use()

	if is_using_skill:
		current_skill.skill_casted.connect(_on_skill_casted)
	else:
		current_skill = null

	return is_using_skill


func _on_skill_casted():
	is_using_skill = false

	current_skill.skill_casted.disconnect(_on_skill_casted)
	current_skill = null
