extends Character

@export var wander_range := 100.0
@export var seek_range := 350.0
@export var idle_interval := 180

@onready var home_position := global_position
@onready var idle_counter := randi() % idle_interval


func _ready() -> void:
	nav_agent = $NavigationAgent2D


#func _physics_process(delta: float) -> void:
	#super(delta)


#func _set_state(new_state: int) -> void:
	#super(new_state)


	#while state == STATE.PURSUE:
		#if global_position.distance_to(target.global_position) > seek_range:
			#_set_state(STATE.IDLE)
			#break
		#if global_position.distance_to(target.global_position) < 96:
			#direction = Vector2.ZERO
			#animate("Attack", "Down")
			#break
		#nav_agent.target_position = target.global_position
		#await get_tree().create_timer(0.5).timeout
#
#
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
	##while state == STATE.EXHAUSTED:
		##animate("Fly", "Down")
		##await get_tree().create_timer(1).timeout
		##if stamina >= max_stamina * 0.5:
			##_set_state(STATE.IDLE)
			##break

#func change_direction() -> void:
		##if state == STATE.IDLE or state == STATE.PURSUE:
			#animate("Fly", sprite_direction)
#
#
#func take_damage(damage_amount, damage_position) -> void:
	#super(damage_amount, damage_position)
	#_set_state(STATE.PURSUE)
#
#
#func dash(x: float, y: float) -> void:
	#velocity += Vector2(x, y) * speed
#
#func _on_detector_body_entered(body: Node2D) -> void:
		#target = body
		#_set_state(STATE.PURSUE)
#
#
#func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	#if anim_name.contains("Attack"):
		#_set_state(STATE.IDLE)
