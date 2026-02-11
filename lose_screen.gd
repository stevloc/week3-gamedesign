extends Node2D

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") or Input.is_key_pressed(KEY_R):
		restart_game()

func restart_game() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
