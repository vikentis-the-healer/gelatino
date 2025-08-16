class_name Character extends CharacterBody2D


#var is_player := false
#var target : Node
var states_dict : Dictionary

var state : Node:
	set(new_state):
		if state:
			state.exit()
		state = new_state
		state.enter()

var animation : StringName:
	set(new_animation):
		if animation == new_animation:
			return
		animation = new_animation
		if animation == &"Death":
			animation_player.play(animation)
			return
		animation_player.play(animation + sprite_direction)
		#print(str(animation) + str(direction))

var direction: Vector2:
	set(new_direction):
		if new_direction == direction:
			return
		direction = new_direction
		if direction.x > 0.7:
			sprite_direction = &"Right"
		elif direction.x < -0.7:
			sprite_direction = &"Left"
		elif direction.y > 0.7:
			sprite_direction = &"Down"
		elif direction.y < -0.7:
			sprite_direction = &"Up"
		#print("New Direction= " + str(direction))

var sprite_direction := &"Down":
	set(new_sprite_direction):
		sprite.flip_h = false
		if new_sprite_direction == &"Right":
			new_sprite_direction = &"Side"
		elif new_sprite_direction == &"Left":
			new_sprite_direction = &"Side"
			sprite.flip_h = true
		if sprite_direction == new_sprite_direction:
			return
		sprite_direction = new_sprite_direction
		animation_player.play(animation + sprite_direction)
		#print(str(animation) + str(sprite_direction))

@export var max_health := 2
@export var max_stamina := 10.0
@export var speed := 200
@export var accel := 1000

@onready var health := max_health
@onready var stamina := max_stamina
@onready var stamina_restore = max_stamina * 0.05
@onready var init_speed := speed
@onready var init_accel := accel
@onready var sprite := $Sprite2D
@onready var shadow := $Shadow
@onready var animation_player := $AnimationPlayer

func _init() -> void:
	add_to_group("characters")

##Prints a text string preceded by the character's name
func speak(text : String) -> void:
	print(str(name) + ": " + text)


func _ready() -> void:
	for i in find_children("*", "State"):
		states_dict[i.name] = i
	state = states_dict.values()[0]
	#if not is_player:
		#nav_agent = $NavigationAgent2D


func _process(_delta: float) -> void:
	if stamina <= 0:
		state = states_dict.Exhausted


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


##Decreases health by damage_amount. If health drops below zero,
##sets the character state to dead. Otherwise, creates hitflash
##and knockback.
func take_damage(damage_amount, damage_source_position):
	health -= damage_amount
	if health <= 0:
		state = states_dict.Dead
		return
	velocity += damage_source_position.direction_to(global_position) * (damage_amount * 50 + 300)
	$Sprite2D.self_modulate = Color.RED
	await get_tree().create_timer(0.2).timeout
	$Sprite2D.self_modulate = Color.WHITE
