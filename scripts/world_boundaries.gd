@tool
extends StaticBody2D


@export_range(32.0, 3200.0, 16.0) var top := 256.0
@export_range(32.0, 3200.0, 16.0) var bottom := 256.0
@export_range(32.0, 3200.0, 16.0) var left := 256.0
@export_range(32.0, 3200.0, 16.0) var right := 256.0

func _process(_delta: float) -> void:
	$Top.position.y = top * -1
	$Bottom.position.y = bottom
	$Right.position.x = right
	$Left.position.x = left * -1
