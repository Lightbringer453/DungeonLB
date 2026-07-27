extends CharacterBody2D

@export var speed: float = 300.0

@onready var health_component = $HealthComponent

func _ready() -> void:
	health_component.died.connect(_on_died)

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
		"ui_down"
	)

	velocity = direction * speed
	move_and_slide()

func _on_died() -> void:
	print("Player died")
