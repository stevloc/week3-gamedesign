extends Area2D

@export var trigger_color: Player.PlayerColor = Player.PlayerColor.BLUE

@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	_apply_visual_color()
	pass

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.subtract_color(trigger_color)

func _apply_visual_color() -> void:
	match trigger_color:
		Player.PlayerColor.RED:
			color_rect.color = Color(1, 0, 0, 1)
		Player.PlayerColor.BLUE:
			color_rect.color = Color(0, 0, 1, 1)
		Player.PlayerColor.YELLOW:
			color_rect.color = Color(1, 1, 0, 1)
		Player.PlayerColor.GREEN:
			color_rect.color = Color(0, 1, 0, 1)
		Player.PlayerColor.PURPLE:
			color_rect.color = Color(0.5, 0, 0.5, 1)
		Player.PlayerColor.ORANGE:
			color_rect.color = Color(1, 0.5, 0, 1)
		Player.PlayerColor.WHITE:
			color_rect.color = Color(1, 1, 1, 1)
		Player.PlayerColor.PINK:
			color_rect.color = Color(1, 0.4, 0.7, 1)
