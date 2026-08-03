extends Node2D

@onready var skeleton_scene = preload("res://Scenes/skeleton.tscn")
@onready var dark_skeleton_scene = preload("res://Scenes/dark_skeleton.tscn")
@onready var pumpkin_scene = preload("res://Scenes/pumpkin.tscn")
@onready var ogre_king_scene  = preload("res://Scenes/ogre_king.tscn")
@onready var blue_ghost_scene = preload("res://Scenes/blue_ghost.tscn")

var list_monsters = []
var num_monster_selected = 0

func _ready() -> void:
	list_monsters = [skeleton_scene,dark_skeleton_scene,pumpkin_scene,ogre_king_scene,blue_ghost_scene]


func _process(delta: float) -> void:

	if get_child_count() == 2:
		for i in range($Monsters.get_child_count()):
			num_monster_selected = randi_range(0,list_monsters.size() -1)
			var monster_selected = list_monsters[num_monster_selected]
			var monster_scene_instance = monster_selected.instantiate()
			var node_position = get_node("Monsters/Marker2D" + str(i + 1))
			monster_scene_instance.global_position = node_position.global_position
			monster_scene_instance.name = str(i)
			add_child(monster_scene_instance)
