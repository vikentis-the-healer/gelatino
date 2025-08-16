extends State


	##while state == STATE.EXHAUSTED:
		##animate("Fly", "Down")
		##await get_tree().create_timer(1).timeout
		##if stamina >= max_stamina * 0.5:
			##_set_state(STATE.IDLE)
			##break
