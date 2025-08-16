extends State


func enter() -> void:
	actor.animation = &"Exhausted"
	actor.speed *= 0.3
	print(actor.speed)
	actor.gui.stamina_bar.self_modulate = Color.AQUA
	$"../Sweating".emitting = true
	actor.stamina = 0.0


func physics_update(delta) -> void:
	actor.steer(delta)
	actor.move_and_slide()
	if actor.move_and_slide():
		var bounce_angle = actor.get_last_slide_collision().get_normal()
		actor.velocity = actor.velocity.bounce(bounce_angle)
	actor.stamina += actor.stamina_restore * delta
	if actor.stamina >= actor.max_stamina * 0.33:
		actor.state = actor.states_dict.Walking


func exit() -> void:
	actor.speed = actor.init_speed
	print(actor.speed)
	actor.gui.stamina_bar.self_modulate = Color.GREEN
	$"../Sweating".emitting = false
