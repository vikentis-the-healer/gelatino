extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.health = PlayerData.max_health
		Global.save_game(position, get_parent().name)
