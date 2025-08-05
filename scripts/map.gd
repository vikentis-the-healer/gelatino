class_name Map extends Node

@export var needs_player := true
@export var needs_debug_cam := false

const PLAYER_PATH = preload("res://scenes/player.tscn")
const DEBUG_CAM_PATH = preload("res://debug_cam.gd")

func _ready() -> void:
	if needs_player:
		var player = PLAYER_PATH.instantiate()
		add_child(player)
	if needs_debug_cam:
		var debug_cam
		add_child(debug_cam)
