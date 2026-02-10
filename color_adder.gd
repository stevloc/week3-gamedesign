extends Area2D

@export var trigger_color: Player.PlayerColor = Player.PlayerColor.BLUE

@onready var polygon: Polygon2D = $Polygon2D

func _ready() -> void:
	_apply_visual_color()
	pass

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.add_color(trigger_color)

func _apply_visual_color() -> void:
	match trigger_color:
		Player.PlayerColor.RED:
			polygon.color = Color(1, 0, 0, 1)
		Player.PlayerColor.BLUE:
			polygon.color = Color(0, 0, 1, 1)
		Player.PlayerColor.YELLOW:
			polygon.color = Color(1, 1, 0, 1)
		Player.PlayerColor.GREEN:
			polygon.color = Color(0, 1, 0, 1)
		Player.PlayerColor.PURPLE:
			polygon.color = Color(0.5, 0, 0.5, 1)
		Player.PlayerColor.ORANGE:
			polygon.color = Color(1, 0.5, 0, 1)
		Player.PlayerColor.WHITE:
			polygon.color = Color(1, 1, 1, 1)
		Player.PlayerColor.PINK:
			polygon.color = Color(1, 0.4, 0.7, 1)
