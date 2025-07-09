extends CharacterBody2D

var smoke_cloud = preload("res://smoke_cloud.tscn")

# This enum lists all the possible states the character can be in.
enum States {IDLE, PURSUE, WANDER, ATTACK}

# This variable keeps track of the character's current state.
var state := States.IDLE
var sprite_direction : String
var player = null
var health := 2
var dead = false
var time_left : int
@export var SPEED := 500.0

func _ready() -> void:
	$AnimatedSprite2D.frame_progress = randf()

func _process(delta: float) -> void:
	if health <= 0:
		die()
	
	control_sprite()
	
	if state == States.IDLE:
		$AnimatedSprite2D.play("Idle")
	elif state == States.PURSUE:
		#$AnimatedSprite2D.play("Walk" + sprite_direction)
		$AnimatedSprite2D.play("AttackDown")
		velocity = (player.position - position).normalized() * SPEED * delta
		var distance_to_player = player.position - position
		if distance_to_player.length() < 5:
			state == States.ATTACK
	elif state == States.ATTACK:
		$AnimatedSprite2D.play("AttackDown")
	move_and_slide()

func die():
	if not dead:
		$AnimatedSprite2D.visible = false
		$CollisionShape2D.disabled = true
		time_left = 90
		var instance = smoke_cloud.instantiate()
		add_child(instance)
		instance.emitting = true
		dead = true
	else:
		time_left -= 1
		if time_left < 0:
			queue_free()

func control_sprite():
	$AnimatedSprite2D.flip_h = false

	if velocity.x < -5:
		sprite_direction = "Side"
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 5:
		sprite_direction = "Side"
	elif velocity.y < -5:
		sprite_direction = "Down"
	else:
		sprite_direction = "Down"

func _on_detection_radius_body_entered(body: CharacterBody2D) -> void:
	if state == States.IDLE:
		state = States.PURSUE
		player = body


func _on_detection_radius_body_exited(_body: CharacterBody2D) -> void:
	if state == States.PURSUE:
		state = States.IDLE
