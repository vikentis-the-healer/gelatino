extends Area2D

@export var damage := 1

func _ready() -> void:
	$Label.text = str(damage)
	$HitBox.damage = damage
