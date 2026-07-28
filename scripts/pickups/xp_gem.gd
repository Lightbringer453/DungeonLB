extends Area2D

@export var xp_amount: int = 1


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return

	var experience_component = body.get_node("ExperienceComponent")

	if experience_component:
		experience_component.add_xp(xp_amount)

	queue_free()
