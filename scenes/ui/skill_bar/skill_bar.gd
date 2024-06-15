class_name SkillBar
extends HBoxContainer

@export var skill_component: SkillComponent = null

var _skills: Array[Skill] = []

@onready
var _button_mapper: Array[Button] = [%SkillButton0, %SkillButton1, %SkillButton2, %SkillButton3]

@onready var _button_timeout_label_mapper: Array[Label] = [
	$SkillButton0/TimeoutLabel,
	$SkillButton1/TimeoutLabel,
	$SkillButton2/TimeoutLabel,
	$SkillButton3/TimeoutLabel
]


# Called when the node enters the scene tree for the first time.
func _ready():
	_load_skills()


func _process(_delta):
	_check_skill_timeout()


func _load_skills():
	_skills = skill_component.get_skills()
	var i: int = 0
	for skill in _skills:
		_button_mapper[i].text = skill.skill_class
		i += 1


func _check_skill_timeout():
	var i: int = 0
	for skill in _skills:
		var skill_button: Button = _button_mapper[i]
		skill_button.disabled = !skill.is_ready()

		var skill_button_timeout_label: Label = _button_timeout_label_mapper[i]
		skill_button_timeout_label.visible = skill_button.disabled

		if skill_button.disabled:
			var time_left: float = skill.get_timeout_timer_timeleft()
			skill_button_timeout_label.text = (
				"%02d:%02d" % [floor(time_left / 60), int(time_left) % 60]
			)

		i += 1
