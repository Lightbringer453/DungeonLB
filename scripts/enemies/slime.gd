extends CharacterBody2D

@export var move_speed: float = 120.0
@export var stopping_distance: float = 45.0
@export var damage: int = 10
@export var attack_cooldown: float = 1.0

var player: CharacterBody2D
var can_attack: bool = true

@onready var hitbox: Area2D = $Hitbox


func _ready() -> void:
	player = get_tree().current_scene.get_node("Player") as CharacterBody2D

	if player == null:
		push_warning("Player bulunamadı.")
		return

	hitbox.area_entered.connect(_on_hitbox_area_entered)


func _physics_process(_delta: float) -> void:
	if player == null:
		velocity = Vector2.ZERO
		return

	var distance_to_player: float = global_position.distance_to(
		player.global_position
	)

	if distance_to_player > stopping_distance:
		var direction: Vector2 = global_position.direction_to(
			player.global_position
		)

		velocity = direction * move_speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name != "Hurtbox":
		return

	attack(area)


func attack(hurtbox: Area2D) -> void:
	if not can_attack:
		return

	hurtbox.damage(damage)

	can_attack = false

	await get_tree().create_timer(attack_cooldown).timeout

	can_attack = true
