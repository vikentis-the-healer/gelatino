class_name HitBox extends Area2D

@export var damage := 1

func _ready() -> void:
	connect("body_entered", self._on_hit_box_body_entered)

func _on_hit_box_body_entered(body: Node2D) -> void:
	print(body)
	body.take_damage(damage, global_position)
