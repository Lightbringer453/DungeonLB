extends CharacterBody2D

# Slime'ın hareket hızı.
@export var move_speed: float = 120.0

# Slime oyuncuya bu mesafeden daha yakınsa hareket etmeyi bırakır.
@export var stopping_distance: float = 45.0

# Oyuncu node'unu burada tutacağız.
var player: CharacterBody2D


func _ready() -> void:
	player = get_tree().current_scene.get_node("Player") as CharacterBody2D

	if player == null:
		push_warning("Player bulunamadı.")

func _physics_process(_delta: float) -> void:
	# Oyuncu bulunamadıysa hareket etme.
	if player == null:
		velocity = Vector2.ZERO
		return

	# Slime ile oyuncu arasındaki mesafeyi hesapla.
	var distance_to_player: float = global_position.distance_to(player.global_position)

	# Oyuncuya yeterince uzaktaysa ona doğru hareket et.
	if distance_to_player > stopping_distance:
		var direction: Vector2 = global_position.direction_to(player.global_position)
		velocity = direction * move_speed
	else:
		# Oyuncuya çok yaklaştığında dur.
		velocity = Vector2.ZERO

	move_and_slide()
