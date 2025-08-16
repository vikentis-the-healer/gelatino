extends NPCState

var pursuit_cooldown: int


func physics_update(delta: float) -> void:
	if npc.global_position.distance_to(npc.target.global_position) > npc.seek_range:
		finished.emit(IDLE)
		return
	elif npc.global_position.distance_to(npc.target.global_position) < npc.striking_distance:
		finished.emit(ATTACKING)
		return

	npc.nav_agent.target_position = npc.target.global_position
