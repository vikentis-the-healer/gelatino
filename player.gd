extends CharacterBody2D
@export var speed = 20

# This enum lists all the possible states the character can be in.
enum States {WALK, DASH, JUMP}

# This variable keeps track of the character's current state.
var state := States.WALK
var animation := "Walk"
var sprite_direction : String
var dx := 0.0
var dy := 0.0
var dz := 0.0
var sprite_height := 0.0
var dash_time := 0
	
func _physics_process(delta: float) -> void:
	dx = speed * Input.get_axis("Left", "Right")
	dy = speed * Input.get_axis("Up", "Down")
	if state == States.WALK:
		animation = "Walk"
		if Input.is_action_pressed("Jump"):
			jump()
		if Input.is_action_just_pressed("Dash"):
			dash()
	elif state == States.JUMP:
		animation = "Jump"
		$AnimatedSprite2D.position.y += dz
		dz += 0.5
		dx *= 1.5
		dy *= 1.5
		if $AnimatedSprite2D.position.y >= -10:
			$AnimatedSprite2D.position.y = -10
			state = States.WALK
		#if dz < 20:
			#dz += 0.5
	elif state == States.DASH:
		animation = "Dash"
		print("Dashing")
		dx *= 3
		dy *= 3
		dash_time -= 1
		if dash_time <= 0:
			state = States.WALK
	
	velocity *= 0.9
	velocity += Vector2(dx, dy)
	move_and_slide()
	
	if velocity.x < -5:
		sprite_direction = "Left"
	elif velocity.x > 5:
		sprite_direction = "Right"
	elif velocity.y < -5:
		sprite_direction = "Up"
	else:
		sprite_direction = "Down"
	
	set_animation()
	
	#if abs(velocity.x) < 2 and abs(velocity.y) < 2:
		#$AnimatedSprite2D.stop()
	
func set_animation():
	var direction = "Side" if sprite_direction in ["Left", "Right"] else sprite_direction 
	$AnimatedSprite2D.flip_h = (sprite_direction == "Left")
	$AnimatedSprite2D.play(animation + direction)
	
func jump():
	state = States.JUMP
	#print(state)
	$JumpSFX.play()
	#$CollisionShape2D.disabled = true
	dz = -10
	
func dash():
	state = States.DASH
	#print(state)
	$DashSFX.play()
	dash_time = 30
