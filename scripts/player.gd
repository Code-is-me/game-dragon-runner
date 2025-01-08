extends CharacterBody2D

@onready var jump_sfx: AudioStreamPlayer2D = $Jump_sfx


const SPEED = 130.0
const JUMP_VELOCITY = -280.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sfx.play()

	# Get the input direction: -1, 0 , 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# flip the sprite 
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# play animtions
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else :
			animated_sprite.play("run")
	else :
		animated_sprite.play("jump")
	
	
	# Apply the movement 
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_animated_sprite_2d_frame_changed() -> void:
	pass # Replace with function body.
