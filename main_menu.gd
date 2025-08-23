extends Control

func _ready() -> void:
	$AudioStreamPlayer2D.play()
	$settings.hide()
	$main/VBoxContainer2.show()


func _on_button_pressed() -> void:
	$main/VBoxContainer2/Button/AudioStreamPlayer2D.play()
	get_tree().change_scene_to_file("res://play_scene.tscn")
	


func _on_button_2_pressed() -> void:
	$main/VBoxContainer2/Button/AudioStreamPlayer2D.play()
	$settings.show()
	$main/VBoxContainer2.hide()


func _on_button_3_pressed() -> void:
	$main/VBoxContainer2/Button/AudioStreamPlayer2D.play()
	get_tree().quit()


func _on_button_mouse_entered() -> void:
	$main/VBoxContainer2/Button/AudioStreamPlayer2D.play()


func _on_button_2_mouse_entered() -> void:
	$main/VBoxContainer2/Button/AudioStreamPlayer2D.play()


func _on_button_3_mouse_entered() -> void:
	$main/VBoxContainer2/Button/AudioStreamPlayer2D.play()


func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value))


func _on_to_menu_pressed() -> void:
	$main/VBoxContainer2/Button/AudioStreamPlayer2D.play()
	$settings.hide()
	$main/VBoxContainer2.show()
