extends State


func enter() -> void:
	actor.animation = &"Death"
	await get_tree().create_timer(1).timeout
	$"../DeathPop".emitting = true
	actor.sprite.visible = false
	actor.shadow.visible = false
	actor.gui.show_death_menu()
