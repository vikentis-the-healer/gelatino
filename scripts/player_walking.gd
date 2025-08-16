extends State


func enter() -> void:
	actor.animation = &"Walk"


func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("Jump"):
		actor.state = actor.states_dict.Jumping
	if event.is_action_pressed("Dash") and actor.direction.length() > 0.7:
		actor.state = actor.states_dict.Dashing
	if event.is_action_pressed("DebugDamage"):
		actor.take_damage(5, actor.global_position)


func physics_update(delta) -> void:
	actor.steer(delta)
	if actor.move_and_slide():
		var bounce_angle = actor.get_last_slide_collision().get_normal()
		actor.velocity = actor.velocity.bounce(bounce_angle)
	if actor.stamina < actor.max_stamina:
		actor.stamina += actor.stamina_restore * delta
