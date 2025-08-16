class_name NPC extends Character

var target : Node

@export var idle_interval := 60
@export var wander_range := 100.0
@export var pursuit_range := 200.0
@export var striking_distance := 90.0

@onready var home_position := global_position
@onready var nav_agent := $NavigationAgent2D


func _ready() -> void:
	super()
	$Detector/CollisionShape2D.shape.radius = pursuit_range

## Sets the character's nav agent to wander to a certain point
## within a range (variance) of a given point (origin).
func choose_wander_point(origin: Vector2, variance: float) -> void:
	nav_agent.target_position = origin + \
	Vector2(randf_range(-variance, variance), \
	randf_range(-variance, variance))


func steer(delta) -> void:
	#print("Steering")
	var next_path_position: Vector2 = nav_agent.get_next_path_position()
	direction = global_position.direction_to(next_path_position)
	velocity = velocity.move_toward(direction * speed, accel * delta)
	#print(global_position)
	#print(next_path_position)
	#print(direction)
	#$RayCast2D.target_position = next_path_position
