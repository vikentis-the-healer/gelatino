class_name Character extends CharacterBody2D


var direction:= Vector2.ZERO
var sprite_direction := "Down"
var is_player := false
var target : Node
var nav_agent : Node

@export var max_health := 2
@export var max_stamina := 10.0
@export var speed := 200
@export var damp := 0.95


@onready var health := max_health
@onready var stamina := max_stamina
@onready var stamina_restore = max_stamina * 0.05
#@onready var speed := start_speed


func _init() -> void:
	add_to_group("characters")



#
	#if not is_exhausted and stamina < 0.0:
		#_set_exhaustion(true)
	#if is_exhausted and stamina >= max_stamina * 0.5:
		#_set_exhaustion(false)
	#if stamina < max_stamina:
		#stamina += stamina_restore * delta
#
#
func choose_sprite_direction() -> void:
	if abs(direction.x) > abs(direction.y):
		sprite_direction = "Side"
		if direction.x < 0:
			$Sprite2D.flip_h = true
			change_direction()
		else:
			$Sprite2D.flip_h = false
			change_direction()
	elif direction.y < 0:
		sprite_direction = "Up"
		change_direction()
	elif direction.y > 0:
		sprite_direction = "Down"
		change_direction()


func change_direction() -> void:
	pass


func speak(text : String) -> void:
	print(str(name) + ": " + text)


#func _set_exhaustion(new_value: bool) -> void:
	#is_exhausted = new_value
	#if new_value:
		#stamina = 0.0
#
#
#func _set_state(new_state: int) -> void:
	#state = new_state
#

func animate(animation: String, animdir: String)-> void:
	$AnimationPlayer.play(animation + animdir)

## Sets the character's nav agent to wander to a certain point
## within a range (variance) of a given point (origin).
func choose_wander_point(origin: Vector2, variance: float) -> void:
	nav_agent.target_position = origin + \
	Vector2(randf_range(-variance, variance), \
	randf_range(-variance, variance))


func take_damage(damage_amount, damage_source_position):
	health -= damage_amount
	velocity += Vector2(global_position - damage_source_position) * (damage_amount * 20)
	if health <= 0:
		die()
	$Sprite2D.self_modulate = Color.RED
	await get_tree().create_timer(0.2).timeout
	$Sprite2D.self_modulate = Color.WHITE


func die() -> void:
	#state = -1
	$AnimationPlayer.play("Death")
	set_process(false)
	set_physics_process(false)
	$CollisionShape2D.queue_free()
	if not is_player:
		await get_tree().create_timer(5).timeout
		queue_free()
