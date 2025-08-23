extends CharacterBody2D

@export var speed = 100
@export var gravity = 10
@export var jump_force = 150
@export var anti_gravity = false


func _physics_process(delta):
	if anti_gravity ==false:
		if !is_on_floor():
			velocity.y += gravity
			if velocity.y > 500:
				velocity.y = 500
	elif anti_gravity == true:
		velocity.y -= gravity
		if velocity.y < -500:
			velocity.y = -500
			
	#movement
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jump_force
	elif Input.is_action_just_pressed("jump") && is_on_ceiling():
		velocity.y = jump_force
		
	var horizontal_direction = Input.get_axis("left", "right")
	velocity.x = speed * horizontal_direction
	move_and_slide()

#used with repel script
func push_up(vertical_force):
	velocity.y +=vertical_force
	
	
#attract/anti gravity
