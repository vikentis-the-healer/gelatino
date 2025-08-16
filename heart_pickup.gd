extends CharacterBody2D

const HEAL_EFFECT_PATH := preload("res://gfx/smoke_cloud.tscn")

var landed := false

@onready var dz := randf_range(-3.0, -7.0)
@onready var sprite := $Sprite2D


func _ready() -> void:
	velocity = Vector2(randi() % 400 - 200, randi() % 400 - 200)
	await get_tree().create_timer(0.25).timeout
	landed = true

func _physics_process(delta: float) -> void:
	if sprite.position.y + dz > 0:
		dz *= -0.5
	if sprite.position.y > -10.0 and landed:
		$Sprite2D/Area2D.monitoring = true
	else:
		$Sprite2D/Area2D.monitoring = false
	sprite.position.y += dz
	velocity *= 0.97
	dz += 10 * delta
	move_and_slide()
	if abs(dz) < 0.01 and sprite.position.y > -0.1:
		set_physics_process(false)


#func settle_on_ground() -> void:
	#collision_layer = 4
	#
	##print("Settled")



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.heal(10)
		var heal_effect := HEAL_EFFECT_PATH.instantiate()
		heal_effect.emitting = true
		heal_effect.modulate = Color.PINK
		heal_effect.position = global_position
		add_sibling(heal_effect)
		queue_free()
