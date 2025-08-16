extends Area2D

@export var target_scene : String
@export var target_position : Vector2

#@onready var marker = $Marker2D

#var target_position : Vector2



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		PlayerData.checkpoint_position = target_position
		Global.goto_scene(target_scene)
