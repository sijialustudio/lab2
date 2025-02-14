extends Area2D

@export var SPEED = 10.0
@export_group("Controls")
@export var up : String = "player1_up"
@export var down : String = "player1_down"

func _physics_process(delta):
	if Input.is_action_pressed(up):
		position.y -= SPEED
	if Input.is_action_pressed(down):
		position.y += SPEED
