extends Node2D

@export var damage: int = 10
@export var attack_interval: float = 0.8

@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.wait_time = attack_interval
	timer.timeout.connect(_on_timer_timeout)
	timer.start()


func _on_timer_timeout() -> void:
	print("Sword attack")
