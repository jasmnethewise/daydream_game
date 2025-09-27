extends CharacterBody2D

func _ready():
	$AnimatedSprite2D.play("idle")
const SPEED = 300.0
const JUMP_VELOCITY = -500.0

var coin_counter = 0

@onready var coin_sound = $CoinSound
@onready var coin_label = %Label


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("coin"):
		set_coin(coin_counter + 1)
		coin_sound.play()  # هنا الصوت
		print(coin_counter)
		area.queue_free()  # لو عايز الكوين يختفي بعد ما تاخده


func set_coin(new_coin_count: int) -> void:
	coin_counter = new_coin_count
	coin_label.text = "Coin Count: " + str(coin_counter)
