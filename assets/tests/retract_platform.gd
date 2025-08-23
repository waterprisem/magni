extends Area2D

@onready var player = $Player

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.anti_gravity = true
		


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.anti_gravity = false
