extends CharacterBody2D


@onready var animantedSprite = $AnimatedSprite2D
@onready var labelUser = $CanvasLayer/LabelUser
@onready var labelCollect = $CanvasLayer/LabelCollect
@onready var httpRequestId = $HTTPRequestId
@onready var httpRequestPostMonster = $HTTPRequestPostMonster
@onready var labelPostMonster = $CanvasLayer/LabelPostMonster

@export var speed := 200


enum State {
	IDLE_UP,
	IDLE_DOWN,
	IDLE_RIGHT,
	IDLE_LEFT,
	WALK_UP,
	WALK_DOWN,
	WALK_RIGHT,
	WALK_LEFT
}

var current_direction
var can_collect := false
var monster : Area2D

func _ready() -> void:
	labelPostMonster.visible = false
	labelCollect.visible = false
	current_direction = State.IDLE_DOWN
	labelUser.text = "User: " + Globalvar.user


func _process(delta: float) -> void:
	if can_collect:
		collect()
	else:
		labelCollect.visible = false


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left","right","up","down")

	if direction != Vector2.ZERO:
		velocity = direction * speed
		state_machine(direction)
	else:
		velocity = Vector2.ZERO
		var idleState = state_machine(direction)
		if idleState == State.IDLE_DOWN:
			animantedSprite.play("idle_down")
		elif idleState == State.IDLE_UP:
			animantedSprite.play("idle_up")
		elif idleState == State.IDLE_RIGHT:
			animantedSprite.play("idle_right")
		elif idleState == State.IDLE_LEFT:
			animantedSprite.play("idle_left")
		else:
			pass
	
	move_and_slide()


func state_machine(direction:Vector2):
	if direction == Vector2.DOWN:
		animantedSprite.play("walk_down")
		current_direction = State.IDLE_DOWN
	elif direction == Vector2.UP:
		animantedSprite.play("walk_up")
		current_direction = State.IDLE_UP
	elif direction == Vector2.LEFT:
		animantedSprite.play("walk_left")
		current_direction = State.IDLE_LEFT
	elif direction == Vector2.RIGHT:
		animantedSprite.play("walk_right")
		current_direction = State.IDLE_RIGHT
	else:
		pass
	return current_direction
	


func _on_area_2d_collector_area_entered(area: Area2D) -> void:
	if area.is_in_group("Monster"):
		monster = area
		can_collect = true



func _on_area_2d_collector_area_exited(area: Area2D) -> void:
	if area.is_in_group("Monster"):
		can_collect = false


func collect():
	labelCollect.visible = true
	if Input.is_action_just_pressed("collect"):
		get_my_id()


func get_my_id():
	var url = "http://127.0.0.1:3000/users/myId/" + Globalvar.user
	httpRequestId.request(url)
	


func post_monster(owner: String):
	var url = "http://127.0.0.1:3000/monsters/insert/" + owner + "/" + monster.name
	httpRequestPostMonster.request(url, [], HTTPClient.METHOD_POST)


func _on_http_request_id_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		var id = JSON.parse_string(body.get_string_from_utf8())
		post_monster(id._id)


func _on_http_request_post_monster_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 201:
		monster.queue_free()
		labelPostMonster.visible = true
		$TimerLabelPostMonster.start()
	else:
		print("error al crear mounstro")




func _on_timer_label_post_monster_timeout() -> void:
	labelPostMonster.visible = false
