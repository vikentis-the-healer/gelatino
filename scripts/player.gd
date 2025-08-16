class_name Player extends Character

@onready var gui = $GUI
@onready var camera = $Camera2D
@onready var bubble_fx = $Sprite2D/BubbleFX

func _init() -> void:
	super()
	max_health = PlayerData.max_health
	max_stamina = PlayerData.max_stamina
	#is_player = true
	if PlayerData.checkpoint_position:
		position = PlayerData.checkpoint_position


func _ready() -> void:
	super()
	$DashHitBox.damage = PlayerData.damage
	gui.visible = true
	camera.limit_left = %WorldBoundaries.left * -1
	camera.limit_right = %WorldBoundaries.right
	camera.limit_top = %WorldBoundaries.top * -1
	camera.limit_bottom = %WorldBoundaries.bottom



func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)
	if event.is_action_pressed("Camera Zoom"):
		camera.cycle_zoom()



func steer(delta) -> void:
	direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = velocity.move_toward(direction * speed, accel * delta)


func heal(amount) -> void:
	health += amount
	health =  clampi(health, 0, max_health)


func take_damage(damage_amount, damage_source_position):
	super(damage_amount, damage_source_position)
	camera.knock(damage_amount * 0.2 + 1.0)


func _on_dash_hit_box_dealt_damage(damage_amount: Variant) -> void:
	camera.knock(damage_amount * 0.3)
