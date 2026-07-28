extends Node

signal xp_changed(current_xp: int, xp_to_next_level: int)
signal level_up(level: int)

@export var xp_to_next_level: int = 10

var current_xp: int = 0
var level: int = 1


func add_xp(amount: int) -> void:
	current_xp += amount

	while current_xp >= xp_to_next_level:
		current_xp -= xp_to_next_level
		level += 1

		print("LEVEL UP! Level:", level)

		level_up.emit(level)

	xp_changed.emit(current_xp, xp_to_next_level)

	print("XP:", current_xp, "/", xp_to_next_level)
