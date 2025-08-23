extends Sprite2D

func _ready():
	$AnimationPlayer.play("hover")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.magnet_collected = true
		body.get_powers()
		$AnimationPlayer.play("hit_flash")
		hide()
