extends Node2D

@export var damage: int = 10
@export var attack_interval: float = 0.8
@export var attack_range: float = 99999.0

@onready var timer: Timer = $Timer
@onready var pivot: Node2D = $Pivot
@onready var hitbox: Area2D = $Pivot/Hitbox

var current_target: Node2D = null


func _ready() -> void:
	timer.wait_time = attack_interval
	timer.timeout.connect(_on_timer_timeout)
	timer.start()


func _process(_delta: float) -> void:
	current_target = find_nearest_enemy()

	if current_target == null:
		return

	var target_rotation := global_position.angle_to_point(current_target.global_position)

	pivot.rotation = lerp_angle(
		pivot.rotation,
		target_rotation,
		0.15
	)


func _on_timer_timeout() -> void:
	if current_target == null:
		return

	attack()


func attack() -> void:
	var areas := hitbox.get_overlapping_areas()

	for area in areas:
		if area.has_method("damage"):
			area.damage(damage)


func find_nearest_enemy() -> Node2D:
	var enemies := get_tree().get_nodes_in_group("enemies")

	var nearest: Node2D = null
	var nearest_distance := INF

	for enemy in enemies:
		var distance := global_position.distance_to(enemy.global_position)

		if distance < nearest_distance and distance <= attack_range:
			nearest_distance = distance
			nearest = enemy

	return nearest
