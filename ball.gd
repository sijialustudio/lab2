extends Area2D

@export var velocity: Vector2 = Vector2(400, 400)  # Increased speed for faster movement
var player1_health: int = 100
var player2_health: int = 100

var player1_charge: int = 0
var player2_charge: int = 0
const SPECIAL_THRESHOLD = 5  # Number of hits needed before special attack

func _ready():
	spawn()  # Start the game with the ball in motion

func _process(delta):
	position += velocity * delta  # Move the ball

	# Bounce off top and bottom walls
	if position.y < 0 or position.y > get_viewport_rect().size.y:
		velocity.y = -velocity.y

func _on_area_entered(area):
	# Check if the ball hits Player 1's paddle
	if area.name == "Paddle":
		velocity.x = -velocity.x  # Reverse direction
		player1_charge += 1  # Increase charge for Player 1

	# Check if the ball hits Player 2's paddle
	elif area.name == "Paddle2":
		velocity.x = -velocity.x  # Reverse direction
		player2_charge += 1  # Increase charge for Player 2

	# Check if ball enters Score Zone for Player 1
	elif area.name == "ScoreZone":
		player1_health -= 10
		check_game_over()
		spawn()  # Reset ball position

	# Check if ball enters Score Zone for Player 2
	elif area.name == "ScoreZone2":
		player2_health -= 10
		check_game_over()
		spawn()  # Reset ball position

func check_game_over():
	if player1_health <= 0:
		print("Player 2 Wins!")
		get_tree().reload_current_scene()

	if player2_health <= 0:
		print("Player 1 Wins!")
		get_tree().reload_current_scene()

func spawn():
	print("Spawning ball...")
	position = get_viewport_rect().size / 2
	velocity = Vector2(randf_range(-500, 500), randf_range(-500, 500))  # Increased random speed
