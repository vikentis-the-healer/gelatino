extends NPC

static var morale := 0

func ready() -> void:
	#super()
	morale += 1


func _on_detector_body_entered(body: Node2D) -> void:
	if body is Player:
		state = states_dict.Pursuing
		target = body
		print(body.name)
