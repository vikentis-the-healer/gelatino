extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_building_one_body_entered(_body: Node2D) -> void:
	$Roofs.visible = false
	print("Raise the roof!")

func _on_building_one_body_exited(_body: Node2D) -> void:
	$Roofs.visible = true
	
