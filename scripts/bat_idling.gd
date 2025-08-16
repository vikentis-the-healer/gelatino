extends State

var idle_timer : int

func enter() -> void:
	#print("Beginning idle")
	actor.animation = &"Walk"
	actor.choose_wander_point\
	(actor.home_position, actor.wander_range)
	idle_timer = randi() % actor.idle_interval

func physics_update(delta) -> void:
	if idle_timer <= 0:
		actor.choose_wander_point\
		(actor.home_position, actor.wander_range)
		idle_timer = randi() % actor.idle_interval
	if actor.nav_agent.is_navigation_finished():
		idle_timer -= 1 * delta
		return

	actor.steer(delta)

	if actor.move_and_slide():
		var bounce_angle = actor.get_last_slide_collision().get_normal()
		actor.velocity = actor.velocity.bounce(bounce_angle)

	if actor.stamina < actor.max_stamina:
		actor.stamina += actor.stamina_restore * delta
