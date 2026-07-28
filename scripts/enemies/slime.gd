extends Area2D

@export var xp_gem_scene: PackedScene
@export var move_speed: float = 120.0
@export var stopping_distance: float = 45.0
@export var damage: int = 10
@export var attack_cooldown: float = 1.0

@onready var health_component = $HealthComponent
@onready var hitbox = $Hitbox

var player: CharacterBody2D
var can_attack := true


func _ready() -> void:
	player = get_tree().current_scene.get_node("Player")

	health_component.died.connect(_on_died)

	hitbox.body_entered.connect(_on_hitbox_body_entered)


func _process(delta: float) -> void:
	if player == null:
		return

	var direction = player.global_position - global_position
	var distance = direction.length()

	if distance > stopping_distance:
		global_position += direction.normalized() * move_speed * delta


func _on_hitbox_body_entered(body: Node) -> void:
	if body != player:
		return

	if !can_attack:
		return

	can_attack = false

	var hurtbox = body.get_node("Hurtbox")

	if hurtbox:
		hurtbox.damage(damage)

	await get_tree().create_timer(attack_cooldown).timeout

	can_attack = true


func _on_died() -> void:
	if xp_gem_scene:
		var gem = xp_gem_scene.instantiate()
		gem.global_position = global_position
		get_tree().current_scene.get_node("PickupContainer").add_child(gem)

	queue_free()
