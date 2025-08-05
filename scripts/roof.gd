extends TileMapLayer

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		visible = false


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		visible = true
