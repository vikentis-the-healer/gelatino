extends NPCState


func enter(previous_state_path: String, data := {}) -> void:
	#npc.velocity.x = 0.0
	#player.animation_player.play("idle")
	pass


func physics_update(delta: float) -> void:
	#player.velocity.y += player.gravity * _delta
	#player.move_and_slide()
#
	#if not player.is_on_floor():
		#finished.emit(FALLING)
	#elif Input.is_action_just_pressed("move_up"):
		#finished.emit(JUMPING)
	#elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		#finished.emit(RUNNING)
	if npc.idle_counter <= 0:
		npc.choose_wander_point(npc.home_position, npc.wander_range)
		npc.idle_counter = randi() % npc.idle_interval
	else:
		npc.idle_counter -= 1


	#npc.velocity *= npc.damp
	if npc.nav_agent.is_target_reached():
		npc.direction = Vector2.ZERO
		return
	var next_path_position: Vector2 = npc.nav_agent.get_next_path_position()
	npc.direction = npc.global_position.direction_to(next_path_position)
	npc.velocity = npc.velocity.move_toward(npc.direction * 100.0, 1000.0 * delta)

	#if npc.direction.length_squared() > 1.0:
		#npc.direction = npc.direction.normalized()
	##npc.velocity += npc.direction * npc.speed * delta
	#npc.velocity = npc.velocity.lerp(npc.direction * npc.speed, accel * delta)
	#npc.choose_sprite_direction()
	#npc.velocity = npc.velocity.move_toward(npc.direction * npc.speed, 200.0 * delta)
	#lerp()
	#look_at()

	npc.move_and_slide()
