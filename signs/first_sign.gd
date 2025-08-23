extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var speech_sound = preload("res://sfx/Wood Block1.wav")

const lines: Array[String] = [
	"oh hey there!",
	"Magni, right?",
	"You don't remember?",
	"oh well...",
	"we need you on a misson right now!!",
	"get to the surface quickly!"
]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	DialogManager.start_dialog(global_position, lines, speech_sound)
	await DialogManager.dialog_finished
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass
