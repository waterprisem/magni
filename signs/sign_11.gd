extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var speech_sound = preload("res://sfx/Wood Block1.wav")

@export var player: CharacterBody2D
@export var timer_text: Label
var end = "loss"


var lines: Array[String] = [
	"congrats, you're at the top",
	"you've worked hard to make it",
	"unfortunatly you took too long",
	"this is not a passing score",
	"(sighs)",
	"It's ok...",
	"you won't remember it anyways..."
	]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	player.stop_timer()
	if int(timer_text.text) < 300:
		lines = [
			"congrats, you're at the top",
			"you've worked hard to make it",
			"you've completed the test in time",
			"and luckily, you've passed",
			"congrats Magni",
			"you'll be given your first task soon..."
		]
		end = "win"
	DialogManager.start_dialog(global_position, lines, speech_sound)
	await DialogManager.dialog_finished
	
	player.end_game(end)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass
