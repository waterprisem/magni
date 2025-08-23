extends Area2D

var upward_force = -30
var player

func _physics_process(delta: float) -> void:
	if player:
		player.push_up(upward_force)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = null
