extends CanvasLayer


@onready var health_bar = $Bars/HealthBar
@onready var stamina_bar = $Bars/StaminaBar
@onready var player = get_parent()
@onready var paused := false


func _ready() -> void:
	health_bar.max_value = player.max_health
	stamina_bar.max_value = player.max_stamina
	stamina_bar.self_modulate = Color.GREEN


func _process(_delta: float) -> void:
	health_bar.value = player.health
	stamina_bar.value = player.stamina
	if Input.is_action_just_pressed("Pause"):
		pause()
		#for i in get_tree().get_nodes_in_group("characters"):
			#print(i.name)


func pause() -> void:
	paused = not paused
	if paused:
		get_tree().paused = true
		$Bars/Stats/MaxHealth.text = "Maximum Health: " + str(player.max_health)
		$Bars/Stats/MaxStam.text = "Maximum Stamina: " + str(player.max_stamina)
		$Bars/Stats/Damage.text = "Damage on Hit: " + str(PlayerData.damage)
		#
		#$CharacterList.clear()
		#for i in get_tree().get_nodes_in_group("characters"):
			#$CharacterList.add_item(i.name)
		#
		$PauseMenu.visible = true
		$Bars/Stats.visible = true
		#$CharacterList.visible = true
		$PauseMenu/Resume.grab_focus()
	else:
		$PauseMenu.visible = false
		$Bars/Stats.visible = false
		#$CharacterList.visible = false
		get_tree().paused = false
		

func show_death_menu() -> void:
		$DeathMenu.visible = true
		$DeathMenu/HBoxContainer/Reload.grab_focus()


func _on_resume_pressed() -> void:
	pause()

func _on_load_last_save_pressed() -> void:
	Global.load_game()
	get_tree().paused = false
	

func _on_quit_to_menu_pressed() -> void:
	Global.goto_scene("title")
	get_tree().paused = false


func _on_quit_to_desktop_pressed() -> void:
	get_tree().quit()


func _on_reload_pressed() -> void:
	Global.load_game()


func _on_quit_pressed() -> void:
	Global.goto_scene("title")


#func _on_character_list_item_activated(index: int) -> void:
	#var characters = get_tree().get_nodes_in_group("characters")
#
#
#func _on_character_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	#print("character")
