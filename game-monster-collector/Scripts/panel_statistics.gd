extends Panel


@onready var inventory = $"../ItemList"
@onready var httpRequestStatistics = $HTTPRequestStatisticsMonster
@onready var labelLevel = $LabelLevel
@onready var labelName = $LabelName
@onready var httpRequestNewLevel = $HTTPRequestNewLevel
@onready var httpRequestDelete = $HTTPRequestDelete
@onready var labelSelectMonster = $"../../LabelSelectMonster"


var idMonsterSelected
var monsterLevel

signal reload_monsters

func _ready() -> void:
	$"../../LabelSelectMonster".visible = true
	visible = false


func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	$"../../LabelSelectMonster".visible = false
	visible = true
	match inventory.get_item_text(index):
		"Skeleton":
			$AnimatedSprite2D.play("Skeleton")
		"Pumpkin":
			$AnimatedSprite2D.play("Pumpkin")
		"BlueGhost":
			$AnimatedSprite2D.play("BlueGhost")
		"DarkSkeleton":
			$AnimatedSprite2D.play("DarkSkeleton")
		"OgreKing":
			$AnimatedSprite2D.play("OgreKing")

	var url = "http://127.0.0.1:3000/monsters/properties/" + str(Globalvar.myMonsters[index])
	httpRequestStatistics.request(url)



func _on_http_request_statistics_monster_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		var monster = JSON.parse_string(body.get_string_from_utf8())
		labelName.text = monster[0].name
		labelLevel.text = "Level: " + str(int(monster[0].level))
		idMonsterSelected = monster[0]._id
		monsterLevel = monster[0].level
	else:
		print("error a cargar propiedades")



func _on_button_update_pressed() -> void:
	if idMonsterSelected == null:
		return
		
	var new_level = int(monsterLevel) + 1
	var url = "http://127.0.0.1:3000/monsters/update/" + str(idMonsterSelected) + "/" + str(new_level)
	
	$ButtonUpdate.disabled = true
	httpRequestNewLevel.request(url, [], HTTPClient.METHOD_PATCH)

func _on_http_request_new_level_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	$ButtonUpdate.disabled = false
	if response_code == 200:
		var monster = JSON.parse_string(body.get_string_from_utf8())
		if monster is Array and monster.size() > 0:
			monster = monster[0]
			
		monsterLevel = monster.level
		labelLevel.text = "Level: " + str(int(monsterLevel))
		
		reload_monsters.emit()
	else:
		print("Error al actualizar nivel")


func _on_button_delete_pressed() -> void:
	var url = "http://127.0.0.1:3000/monsters/deleteMonster/" + str(idMonsterSelected)
	httpRequestDelete.request(url, [], HTTPClient.METHOD_DELETE)

func _on_http_request_delete_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		Globalvar.myMonsters = []
		visible = false
		labelSelectMonster.visible = true
		reload_monsters.emit()
