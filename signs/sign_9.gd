extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var speech_sound = preload("res://sfx/Wood Block1.wav")

const lines: Array[String] = [
	"getting stuck?",
	"just keep trying...",
	"tip: run up to","the 2nd platform,", "jump and switch color", "timing is key"
	]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	DialogManager.start_dialog(global_position, lines, speech_sound)
	await DialogManager.is_dialog_active

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass
