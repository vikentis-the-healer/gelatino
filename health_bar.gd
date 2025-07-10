extends Node2D

@onready var health : int

func _process(_delta: float) -> void:
	health = get_node("../../Player").health 
	queue_redraw()
		
func _draw():
	draw_rect(Rect2(2, 2, 82, 8), Color.BLACK, true)
	draw_rect(Rect2(2, 2, health * 4, 6), Color.RED, true)
