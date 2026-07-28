extends CanvasLayer

@onready var level_label: Label = $Control/LevelLabel
@onready var xp_bar: ProgressBar = $Control/ProgressBar
@onready var xp_label: Label = $Control/XPLabel


func _ready() -> void:
	var experience = get_tree().current_scene.get_node("Player/ExperienceComponent")

	experience.xp_changed.connect(_on_xp_changed)
	experience.level_up.connect(_on_level_up)

	_on_xp_changed(experience.current_xp, experience.xp_to_next_level)
	level_label.text = "Level %d" % experience.level


func _on_xp_changed(current_xp: int, max_xp: int) -> void:
	xp_bar.max_value = max_xp
	xp_bar.value = current_xp

	xp_label.text = "%d / %d XP" % [current_xp, max_xp]


func _on_level_up(level: int) -> void:
	level_label.text = "Level %d" % level
