extends State


func physics_update(delta) -> void:
	if actor.global_position.distance_to\
	(actor.target.global_position) > actor.pursuit_range:
		actor.state = actor.states_dict.Idling
		return
	actor.nav_agent.target_position = actor.target.global_position

	actor.steer(delta)

	if actor.move_and_slide():
		var bounce_angle = actor.get_last_slide_collision().get_normal()
		actor.velocity = actor.velocity.bounce(bounce_angle)

	if actor.stamina < actor.max_stamina:
		actor.stamina += actor.stamina_restore * delta
