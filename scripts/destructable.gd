class_name Destructable extends RigidBody2D

@export var health := 1


func take_damage(damage_amount, damage_source_position):
	health -= damage_amount
	if health <= 0:
		die()


func die() -> void:
	$Sprite2D.visible = false
	$DeathFX.emitting = true
	set_process(false) 
	set_physics_process(false)
	$CollisionShape2D.queue_free()
	await get_tree().create_timer(5).timeout
	queue_free()
