class_name Destructable extends RigidBody2D

@export var health := 1

const HEALTH_PICKUP_PATH = preload("res://scenes/heart_pickup.tscn")


func take_damage(damage_amount, damage_source_position) -> void:
	health -= damage_amount
	apply_central_force((global_position - damage_source_position) * (damage_amount * 30 + 20))
	if health <= 0:
		die()


func die() -> void:
	var chance := randf()
	if chance > 0.0:
		var health_pickup = HEALTH_PICKUP_PATH.instantiate()
		health_pickup.position = global_position
		add_sibling(health_pickup)
	$Sprite2D.visible = false
	$DeathFX.emitting = true
	set_process(false)
	set_physics_process(false)
	$CollisionShape2D.queue_free()
	await get_tree().create_timer(5).timeout
	queue_free()
