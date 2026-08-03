extends Control

@onready var lineUsername = $ColorRect/LineEdit
@onready var httpRequest = $HTTPRequest


func _ready() -> void:
	$ColorRect/LabelNoUsuario.visible = false


func _on_button_login_pressed() -> void:
	var url = "http://127.0.0.1:3000/users/validate/" + lineUsername.text
	httpRequest.request(url)
	$ColorRect/ButtonLogin.disabled = true


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		if json:
			Globalvar.user = lineUsername.text
			get_tree().change_scene_to_file("res://Scenes/world.tscn")
		else:
			$ColorRect/LabelNoUsuario.visible = true
			$ColorRect/ButtonLogin.disabled = false
	else:
		print("error en validacion")


func _on_button_create_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/create_user.tscn")
