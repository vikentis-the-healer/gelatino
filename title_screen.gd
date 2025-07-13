extends Node2D

func _ready() -> void:
	$Dolly/RedKnight.set_process(false)
	$AnimationPlayer.play("jump")
	$Dolly/RedKnight/AnimationPlayer.play("WalkSide")

func _process(_delta: float) -> void:
	 # Button was pressed.
	if Input.is_action_just_pressed("Restart") or Input.is_action_just_pressed("Jump"):
		get_tree().change_scene_to_file("res://temple_level.tscn")
		
