extends Node2D


func _ready() -> void:
	$Dolly/RedKnight.set_process(false)
	$AnimationPlayer.play("jump")
	$Dolly/RedKnight/AnimationPlayer.play("WalkSide")
	$Control/HBoxContainer/Continue.grab_focus()

 
func _on_start_pressed() -> void:
	Global.load_game()

func _on_new_game_pressed() -> void:
	Global.goto_scene("temple")


func _on_quit_pressed() -> void:
	get_tree().quit()
