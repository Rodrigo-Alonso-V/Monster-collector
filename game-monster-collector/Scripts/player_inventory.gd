extends Control

@export var sprite_skeleton: Sprite2D


@onready var httpRequestMyMonsters = $HTTPRequestMyMonsters
@onready var httpRequestGetMonsters = $HTTPRequestGetMonsters
@onready var httpRequestGetMonsterByName = $HTTPRequestMonsterByName
@onready var httpRequestGetMonsterByNameLevel = $HTTPRequestByNameLevel
@onready var inventory = $Panel/ItemList

var idUser

func _ready() -> void:
	load_monsters()



func _on_http_request_my_monsters_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		var id = JSON.parse_string(body.get_string_from_utf8())
		var url = "http://127.0.0.1:3000/monsters/monstersById/" + id._id
		idUser = id._id
		httpRequestGetMonsters.request(url)
	else:
		print("error get")


func _on_http_request_get_monsters_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		var monsters = JSON.parse_string(body.get_string_from_utf8())
		load_monsters_inventory(monsters)
	else:
		print("error")


func load_monsters():
	var url = "http://127.0.0.1:3000/users/myId/" + Globalvar.user
	httpRequestMyMonsters.request(url) 


func load_monsters_inventory(monsters):
	inventory.clear()
	if monsters != []:
		$Panel/LabelInventoryClear.visible = false
		for monster in monsters:
			var sprite_monster: Texture2D
			match monster.name:
				"Skeleton":
					sprite_monster = load("res://Assets/Sprites/Enemies/Inventory/Skeleton.png")
				"Pumpkin":
					sprite_monster = load("res://Assets/Sprites/Enemies/Inventory/Pumpkin.png")
				"DarkSkeleton":
					sprite_monster = load("res://Assets/Sprites/Enemies/Inventory/Dark Skeleton.png")
				"BlueGhost":
					sprite_monster = load("res://Assets/Sprites/Enemies/Inventory/Blue Ghost.png")
				"OgreKing":
					sprite_monster = load("res://Assets/Sprites/Enemies/Inventory/Ogre King.png")
			Globalvar.myMonsters.append(monster._id)
			inventory.add_item(monster.name,sprite_monster)
	else:
		$Panel/LabelInventoryClear.visible = true


func _on_button_pressed() -> void:
	queue_free()


func _on_panel_statistics_reload_monsters() -> void:
	load_monsters()


func _on_line_edit_text_changed(new_text: String) -> void:
	var url = ""
	
	if $Panel/OptionButton.selected == 0:
		url = "http://127.0.0.1:3000/monsters/searchByName/" + str(idUser) + "?newText=" + new_text
	else:
		url = "http://127.0.0.1:3000/monsters/searchByLevelName/" + str(idUser) + "?newText=" + new_text

	httpRequestGetMonsterByName.request(url)


func _on_http_request_monster_by_name_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		var monsters = JSON.parse_string(body.get_string_from_utf8())
		Globalvar.myMonsters = []
		load_monsters_inventory(monsters)
	else:
		print("Error buscando mounstro")
