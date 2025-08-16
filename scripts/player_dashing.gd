extends State

func enter() -> void:
	actor.animation = &"Dash"
	actor.speed *= 2
	print(actor.speed)
	$"../DashSFX".play()
	$"../DashHitBox".monitoring = true


func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("Jump"):
		actor.state = actor.states_dict.Jumping
	if event.is_action_released("Dash"):
		actor.state = actor.states_dict.Walking


func physics_update(delta) -> void:
	actor.steer(delta)
	if actor.move_and_slide():
		var bounce_angle = actor.get_last_slide_collision().get_normal()
		actor.velocity = actor.velocity.bounce(bounce_angle)
	actor.stamina -= 10.0 * delta
	if actor.stamina <= 0.0:
		actor.state = actor.states_dict.Exhausted
	if actor.direction.length() < 0.7:
		actor.state = actor.states_dict.Walking


func exit() -> void:
	actor.speed = actor.init_speed
	print(actor.speed)
	$"../DashHitBox".monitoring = false
