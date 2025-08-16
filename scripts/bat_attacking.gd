extends State

	##while state == STATE.ATTACK:
		##speed *= 1.5
		##nav_agent.target_position = target.global_position
		##nav_agent.target_position += global_position.direction_to(target.global_position) * 50
		##animate("Attack", "Down")
		##await get_tree().create_timer(2).timeout
		##speed = start_speed
		##stamina -= 7.0
		##speak("Stamina: " + str(stamina))
		##if stamina <= 0.0:
			##_set_state(STATE.EXHAUSTED)
			##break
		##else:
			##_set_state(STATE.PURSUE)
			##break
##
