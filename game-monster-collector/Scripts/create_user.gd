extends Control

@onready var LineUsername = $ColorRect/LineEdit
@onready var httpRequestValidate = $HTTPRequestValidate
@onready var httpRequestCreate = $HTTPRequestCreate


func _ready() -> void:
	$ColorRect/LabelNoUsuario.visible = false


func _on_button_create_pressed() -> void:
	var url = "http://127.0.0.1:3000/users/validate/" + LineUsername.text
	httpRequestValidate.request(url)
	$ColorRect/ButtonCreate.disabled = true


func _on_http_request_validate_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		if json:
			$ColorRect/LabelNoUsuario.visible = true
			$ColorRect/ButtonCreate.disabled = false
		else:
			var url = "http://127.0.0.1:3000/users/createUser/" + LineUsername.text
			httpRequestCreate.request(url,[], HTTPClient.METHOD_POST)
	else:
		print("error en validacion")


func _on_http_request_create_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 201:
		print("usuario creado, registre en login")
		get_tree().change_scene_to_file("res://Scenes/login.tscn")
	else:
		print("error en creacion de usuario")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/login.tscn")
