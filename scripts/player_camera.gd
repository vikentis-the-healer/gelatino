extends Camera2D

@export var decay = 0.8  # How quickly the shaking stops [0, 1].
@export var max_offset = Vector2(32, 32)  # Maximum hor/ver shake in pixels.
@export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).

var trauma := 0.0  # Current shake strength.
var zoom_i := 1
var zoom_levels = [
	Vector2(0.5, 0.5),
	Vector2(1.0, 1.0),
	Vector2(2.0, 2.0)
	]

func _ready():
	randomize()


func knock(amount):
	trauma += amount


func _process(delta):
	if trauma > 0.0:
		trauma -= decay * delta
		shake()


func cycle_zoom() -> void:
	zoom_i += 1
	zoom_i = wrapi(zoom_i, 0, 3)
	print(zoom_i)
	zoom = zoom_levels[zoom_i]

func shake():
	print("Shaking")
	var amount = pow(trauma, 2)
	rotation = max_roll * amount * randf_range(-1, 1)
	offset.x = max_offset.x * amount * randf_range(-1, 1)
	offset.y = max_offset.y * amount * randf_range(-1, 1)
