extends Area2D

@onready var health_component = $"../HealthComponent"


func damage(amount: int) -> void:
	if health_component == null:
		push_warning("HealthComponent not found.")
		return

	health_component.take_damage(amount)
