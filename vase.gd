extends RigidBody2D

var fx = preload("res://smoke_cloud.tscn")
var health := 1
var dead := false
var time_left := 90


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if health <= 0:
		die()
		
func die():
	if not dead:
		print("Smash!")
		$Sprite2D.visible = false
		$CollisionShape2D.disabled = true
		var instance = fx.instantiate()
		add_child(instance)
		instance.emitting = true
		dead = true
	time_left -= 1
	if time_left < 0:
		queue_free()
