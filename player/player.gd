extends CharacterBody2D

@export var bg_music: AudioStreamPlayer2D
@export var sound_effect: AudioStreamPlayer2D


@export var animated_sprite: AnimatedSprite2D
var is_moving: bool = false
var is_jumping: bool = false

@export var speed = 100
@export var gravity = 10
@export var jump_force = 150
@export var magnet = "w" #r, w, n (red, white, none)
var anti_gravity = false
var magnet_collected = false
@onready var flash = $AnimationPlayer
var game_end = false

#timer stuff
var time_elapsed := 0.0
var is_stopped = true
@export var label: Label
func start_timer():
	is_stopped = false
func stop_timer() -> void:
	is_stopped = true
	
func _ready() -> void:
	bg_music.play()

func _physics_process(_delta):
	if DialogManager.is_dialog_active:
		return
		
	if !is_stopped:
		time_elapsed += _delta
		label.text = str(time_elapsed).pad_decimals(2)
		
	is_moving = false
	if anti_gravity ==false:
		if !is_on_floor():
			velocity.y += gravity
			if velocity.y > 500:
				velocity.y = 500
		else:
			is_jumping = false
	elif anti_gravity == true:
		is_jumping = false
		velocity.y -= gravity
		if velocity.y < -500:
			velocity.y = -500
	#movement
	if Input.is_action_just_pressed("jump") && is_on_floor():
		is_jumping = true
		velocity.y = -jump_force
	elif Input.is_action_just_pressed("jump") && is_on_ceiling():
		is_jumping = true
		velocity.y = jump_force
		
		
	var horizontal_direction = Input.get_axis("left", "right")
	velocity.x = speed * horizontal_direction
	
	#face correct direction
	if horizontal_direction != 0:
		is_moving = true
		if horizontal_direction > 0:
			animated_sprite.flip_h = false
		elif horizontal_direction <0:
			animated_sprite.flip_h = true
			
	#change magnet
	if Input.is_action_just_pressed("magnet"):
		if magnet_collected:
			if magnet == "n":
				magnet = "r"
			elif magnet == "r":
				magnet = "w"
			elif  magnet == "w":
				magnet = "r"
	
	_handle_animations()

	move_and_slide()

#used with repel script
func push_up(vertical_force):
	velocity.y +=vertical_force
	is_jumping = true

func in_red(direction, force):
	if magnet == "r" && direction=="top":
		push_up(force)
	elif magnet=="r" && direction=="bottom":
		anti_gravity = false
		push_up(-force)
	elif magnet =="w" && direction =="top":
		anti_gravity= false
	elif magnet == "w" && direction == "bottom":
		anti_gravity = true

func in_white(direction, force):
	if magnet == "w" && direction=="top":
		push_up(force)
	elif magnet=="w" && direction=="bottom":
		anti_gravity = false
		push_up(-force)
	elif magnet =="r" && direction =="top":
		anti_gravity = false
	elif magnet == "r" && direction == "bottom":
		anti_gravity = true
	
func _handle_animations():
	if game_end:
		get_tree().change_scene_to_file("res://main_menu.tscn")
	if is_moving:
		if magnet == "n":
			animated_sprite.play("run")
		elif magnet == "r":
			animated_sprite.play("run_red")
		elif magnet == "w":
			animated_sprite.play("run_white")
	elif is_jumping && !is_moving:
		if magnet == "n":
			animated_sprite.play("jump")
		elif magnet == "r":
			animated_sprite.play("jump_red")
		elif magnet == "w":
			animated_sprite.play("jump_white")
	else:
		if magnet == "n":
			animated_sprite.play("idle")
		elif magnet == "r":
			animated_sprite.play("idle_red")
		elif magnet == "w":
			animated_sprite.play("idle_white")
			
func get_powers():
	start_timer()
	if magnet == "n":
		sound_effect.play()
		flash.play("hit_flash")
		magnet = "w"
	await sound_effect.finished
	sound_effect

func end_game(end):
	if end == "win":
		flash.play("hit_flash")
	elif end == "loss":
		flash.play("hit_flash")
		magnet = "n"
	await get_tree().create_timer(1).timeout
	game_end = true
	


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.gd")
