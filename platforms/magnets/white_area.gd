extends Area2D

var player
var force = -30 #negative for up, postive for down
@export var location = "bottom" #top or bottom

func _physics_process(_delta: float) -> void:
	if player:
		player.in_white(location, force)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.anti_gravity = false
		player = null
