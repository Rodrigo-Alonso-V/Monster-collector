extends Area2D

var name_node


func _ready() -> void:
	name_node = name


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		name = "DarkSkeleton"


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		name = name_node
