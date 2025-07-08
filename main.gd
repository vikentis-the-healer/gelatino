extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$DirectionalLight2D.rotation += 0.0001
	

func _on_building_one_body_entered(_body: Node2D) -> void:
	$Roofs.visible = false
	print("Raise the roof!")

func _on_building_one_body_exited(_body: Node2D) -> void:
	$Roofs.visible = true
	
