extends CharacterBody2D

# This enum lists all the possible states the character can be in.
enum States {WALK, DASH, JUMP}

# This variable keeps track of the character's current state.
var health := 20
var state := States.WALK
var sprite_direction := "Down"
@export var SPEED := 20
var dx := 0.0
var dy := 0.0

func _process(delta: float) -> void:
	dx = Input.get_axis("Left", "Right")
	dy = Input.get_axis("Up", "Down")

	control_sprite()

	if state == States.WALK:
		$AnimationPlayer.play("Walk"+sprite_direction)
		if Input.is_action_pressed("Jump"):
			jump()
		if Input.is_action_just_pressed("Dash"):
			dash()
		velocity += Vector2(dx,dy).normalized() * SPEED * delta
		velocity *= Vector2(0.9, 0.9)
		
	if state == States.DASH and velocity.length()<200:
		velocity *= Vector2(1.1,1.1)

	move_and_slide()
	resolve_collisions()
	
	if Input.is_action_pressed("Restart"):
		get_tree().reload_current_scene()

func jump():
	state = States.JUMP
	$AnimationPlayer.play("Jump"+sprite_direction)
	$JumpSFX.play()
	#print(state)

func dash():
	state = States.DASH
	$AnimationPlayer.play("Dash"+sprite_direction)
	$DashSFX.play()
	#print(state)
	
func resolve_collisions() -> void:
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var rigid_body := collision.get_collider() as RigidBody2D
		var character_body := collision.get_collider() as CharacterBody2D
		if rigid_body:
			rigid_body.apply_central_force(-1 * velocity.length() * collision.get_normal())
			if velocity.length() > 150:
				rigid_body.health -= 1
		if character_body and velocity.length() > 150:
			character_body.health -= 1

func control_sprite():
	$Sprite2d.flip_h = false

	if velocity.x < -5:
		sprite_direction = "Side"
		$Sprite2d.flip_h = true
	elif velocity.x > 5:
		sprite_direction = "Side"
	elif velocity.y < -5:
		sprite_direction = "Up"
	else:
		sprite_direction = "Down"


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	state = States.WALK
	
func take_damage():
	print("Yowch!")
	health -= 1
	print("Health = " + str(health))
