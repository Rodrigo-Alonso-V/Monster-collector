extends CanvasLayer


@onready var inventory_scene = preload("res://Scenes/player_inventory.tscn")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		var inventory_scene_instance = inventory_scene.instantiate()
		add_child(inventory_scene_instance)
