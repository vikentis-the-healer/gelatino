extends Character
#
#const GUI_PATH = preload("res://scenes/gui.tscn")
#
#enum STATE{
	#WALK,
	#DASH,
	#JUMP,
#}
#
#
#func _init() -> void:
	#super()
	#max_health = PlayerData.max_health
	#max_stamina = PlayerData.max_stamina
	##health = max_health
	##stamina = max_stamina
	#is_player = true
	#if PlayerData.checkpoint_position:
		#position = PlayerData.checkpoint_position
	#var gui = GUI_PATH.instantiate()
	#add_child(gui)
#
#
#func _ready() -> void:
	#$DashHitBox.damage = PlayerData.damage
	#
#
#func _input(event: InputEvent) -> void:
	#match state:
		#STATE.WALK:
			#if not is_exhausted:
				#if event.is_action_pressed("Jump"):
					#stamina -= 7.0
					#_set_state(STATE.JUMP)
					#animate("Jump", sprite_direction)
				#if event.is_action_pressed("Dash"):
					#_set_state(STATE.DASH)
		#STATE.DASH:
			#if event.is_action_released("Dash"):
				#_set_state(STATE.WALK)
				#change_direction()
#
#func _physics_process(delta: float) -> void:
	#direction = Input.get_vector("Left", "Right", "Up", "Down")
	#super(delta)
	#if state == STATE.DASH:
		#stamina -= 7 * delta
#
#
#func _set_state(new_state: int) -> void:
	#super(new_state)
	#match state:
		#STATE.DASH:
			#speed = 1500
		#STATE.WALK:
			#speed = 750
#
#
#func change_direction() -> void:
	#if state == STATE.WALK:
		#animate("Walk", sprite_direction)
	#if state == STATE.DASH:
		#animate("Dash", sprite_direction)
#
#
#func _set_exhaustion(new_value: bool) -> void:
	#super(new_value)
	#if new_value:
		#$GUI.stamina_bar.self_modulate = Color.AQUA
		#_set_state(STATE.WALK)
	#else:
		#$GUI.stamina_bar.self_modulate = Color.GREEN
#
#
#func die() -> void:
	#super()
	#await get_tree().create_timer(2).timeout
	#$GUI.show_death_menu()
#
#
#func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	#if state == STATE.JUMP:
		#_set_state(STATE.WALK)
		#change_direction()
