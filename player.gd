extends CharacterBody2D
@export var speed = 20

func _physics_process(delta: float) -> void:
	var dx = speed * Input.get_axis("ui_left", "ui_right")
	var dy = speed * Input.get_axis("ui_up", "ui_down")
	velocity += Vector2(dx, dy)
	velocity *= 0.9
	move_and_slide()
