extends CharacterBody2D


enum States {IDLE, PURSUE, WANDER, ATTACK}


var state := States.IDLE
var sprite_direction : String
var player = null
var health := 5
var dead = false
var time_left : int


@export var SPEED := 500.0


func _ready() -> void:
	$AttackBox/CollisionShape2D.disabled = true
	
func _process(delta: float) -> void:
	if health <= 0:
		die()
	control_sprite()
	
	if state == States.IDLE:
		$AnimationPlayer.play("Idle")
		if player:
			state = States.PURSUE
	elif state == States.PURSUE:
		#print("I see 'em!")
		$AnimationPlayer.play("Walk" + sprite_direction)
		velocity = (player.position - position).normalized() * SPEED * delta
		var distance_to_player = player.position - position
		if distance_to_player.length() < 30:
			#print(distance_to_player.length())
			state = States.ATTACK
	elif state == States.ATTACK:
		$AnimationPlayer.play("Attack" + sprite_direction)
	move_and_slide()

func die():
	if not dead:
		$Sprite2D.visible = false
		$CollisionShape2D.disabled = true
		time_left = 90
		#var instance = smoke_cloud.instantiate()
		#add_child(instance)
		#instance.emitting = true
		dead = true
	else:
		time_left -= 1
		if time_left < 0:
			queue_free()
			
func control_sprite():
	$Sprite2D.flip_h = false
	
	if velocity.x < -5:
		sprite_direction = "Side"
		$Sprite2D.flip_h = true
	elif velocity.x > 5:
		sprite_direction = "Side"
	elif velocity.y < -5:
		sprite_direction = "Down"
	else:
		sprite_direction = "Down"


func take_damage():
	health -= 1

func _on_detection_radius_body_entered(body: CharacterBody2D) -> void:
	player = body


func _on_detection_radius_body_exited(_body: CharacterBody2D) -> void:
	state = States.IDLE
	player = null


func _on_attack_box_body_entered(body) -> void:
	if not dead:
		var target = body
		target.take_damage()
		target.velocity += velocity * 5


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	state = States.IDLE
