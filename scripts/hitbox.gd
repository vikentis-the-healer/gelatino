class_name HitBox extends Area2D

@export var damage := 1

signal dealt_damage(damage_amount)


func _ready() -> void:
	connect("body_entered", self._on_hit_box_body_entered)


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body is Character or body is Destructable:
		body.take_damage(damage, global_position)
		dealt_damage.emit(damage)
