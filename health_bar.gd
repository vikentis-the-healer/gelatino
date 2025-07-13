extends Node2D

var health := 20

func _process(_delta: float) -> void: 
	queue_redraw()
		
func _draw():
	draw_rect(Rect2(2, 2, 85, 10), Color.BLACK, true)
	draw_rect(Rect2(3, 3, health * 4 + 3, 7), Color.RED, true)
