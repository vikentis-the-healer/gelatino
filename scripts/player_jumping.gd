extends State

var sprite_dy : float

@onready var sprite_init : float


func enter() -> void:
	actor.animation = &"Jump"
	$"../JumpSFX".play()
	sprite_dy = -5.0
	sprite_init = actor.sprite.offset.y
	actor.accel *= 0.5
	actor.stamina -= 5.0
	actor.collision_layer = 0
	actor.collision_mask = 2


func physics_update(delta) -> void:
	actor.steer(delta)
	actor.move_and_slide()
	actor.sprite.offset.y += sprite_dy
	actor.sprite.offset.y = clamp(actor.sprite.offset.y, sprite_init - 500.0, sprite_init)
	if actor.sprite.offset.y == sprite_init:
		actor.state = actor.states_dict.Walking
		return
	sprite_dy += 10.0 * delta
	actor.bubble_fx.position.y = actor.sprite.offset.y + 12


func exit() -> void:
	actor.sprite.offset.y = sprite_init
	actor.accel = actor.init_accel
	actor.collision_layer = 1
	actor.collision_mask = 14
