extends Area2D

# Set this in the Inspector to specify which level to load
@export_file("*.tscn") var next_level_path: String = ""

func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if next_level_path != "":
			get_tree().change_scene_to_file(next_level_path)
