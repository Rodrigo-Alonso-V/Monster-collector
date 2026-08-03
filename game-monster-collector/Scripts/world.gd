extends Node2D

var player_scene = preload("res://Scenes/player.tscn")

func _ready() -> void:
	instance_player()


func instance_player():
	var instance_player_scene = player_scene.instantiate()
	instance_player_scene.global_position = $Spawns/Marker2DPlayer.global_position
	add_child(instance_player_scene)
