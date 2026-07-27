extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 2.0
@export var spawn_radius: float = 700.0

@onready var timer: Timer = $Timer

var player: Node2D


func _ready() -> void:
	player = get_tree().current_scene.get_node("Player")

	timer.wait_time = spawn_interval
	timer.timeout.connect(_spawn_enemy)
	timer.start()


func _spawn_enemy() -> void:
	if player == null:
		return

	var enemy = enemy_scene.instantiate()

	var angle: float = randf_range(0.0, TAU)

	var spawn_position: Vector2 = player.global_position + Vector2.RIGHT.rotated(angle) * spawn_radius

	enemy.global_position = spawn_position

	get_tree().current_scene.add_child(enemy)
