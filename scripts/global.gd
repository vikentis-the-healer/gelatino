extends Node

var current_scene : Node

const SAVE_PATH = "user://save_json.json"


func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(-1)
	print(current_scene)


func _input(event: InputEvent) -> void:
	if OS.is_debug_build():
		if event.is_action_pressed("DebugDamage"):
			pass

func goto_scene(path):
	# Defer the scene change till the end of the frame.
	_deferred_goto_scene.call_deferred(path)


func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load("res://scenes/" + path.to_lower() + ".tscn")
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	#get_tree().change_scene_to_file("res://scenes/" + path + ".tscn")

func save_game(save_position, map_name) -> void:
	print("Saving: " + map_name)
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var save_data := {
			position = var_to_str(save_position),
			saved_scene = map_name
		}
	file.store_line(JSON.stringify(save_data))


func load_game() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	var save_data := json.get_data() as Dictionary
	print("Loading:" + save_data.saved_scene)

	PlayerData.checkpoint_position = str_to_var(save_data.position)
	goto_scene(save_data.saved_scene)
