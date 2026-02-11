extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const COYOTE_TIME = 0.1

enum PlayerColor { RED, BLUE, YELLOW, GREEN, PURPLE, ORANGE, WHITE, PINK }
var current_color: PlayerColor = PlayerColor.RED
var coyote_timer: float = 0.0

@onready var color_rect = $ColorRect

func _ready():
	update_color()

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		coyote_timer -= delta
	else:
		coyote_timer = COYOTE_TIME
	
	# Handle jump and color switch - allow jump if on floor or within coyote time
	var can_jump = is_on_floor() or coyote_timer > 0
	if Input.is_action_just_pressed("ui_accept") and can_jump:
		velocity.y = JUMP_VELOCITY
		coyote_timer = 0.0
		#toggle_color()
	
	# Get input direction and handle movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func update_color() -> void:
	# Start with ONLY platform layer (layer 1)
	collision_mask = 0
	set_collision_mask_value(1, true)  # Enable platforms
	
	# Enable ALL color wall layers EXCEPT the matching color
	set_collision_mask_value(2, true)   # Red walls
	set_collision_mask_value(3, true)   # Blue walls
	set_collision_mask_value(4, true)   # Yellow walls
	set_collision_mask_value(5, true)   # Green walls
	set_collision_mask_value(6, true)   # Purple walls
	set_collision_mask_value(7, true)   # Orange walls
	set_collision_mask_value(8, true)   # White walls
	set_collision_mask_value(9, true)   # Pink walls
	
	match current_color:
		PlayerColor.RED:
			color_rect.color = Color(1, 0, 0, 1)
			set_collision_mask_value(2, false)  # Disable red wall collision
		PlayerColor.BLUE:
			color_rect.color = Color(0, 0, 1, 1)
			set_collision_mask_value(3, false)  # Disable blue wall collision
		PlayerColor.YELLOW:
			color_rect.color = Color(1, 1, 0, 1)
			set_collision_mask_value(4, false)  # Disable yellow wall collision
		PlayerColor.GREEN:
			color_rect.color = Color(0, 1, 0, 1)
			set_collision_mask_value(5, false)  # Disable green wall collision
		PlayerColor.PURPLE:
			color_rect.color = Color(0.5, 0, 0.5, 1)
			set_collision_mask_value(6, false)  # Disable purple wall collision
		PlayerColor.ORANGE:
			color_rect.color = Color(1, 0.5, 0, 1)
			set_collision_mask_value(7, false)  # Disable orange wall collision
		PlayerColor.WHITE:
			color_rect.color = Color(1, 1, 1, 1)
			set_collision_mask_value(8, false)  # Disable white wall collision
		PlayerColor.PINK:
			color_rect.color = Color(1, 0.4, 0.7, 1)
			set_collision_mask_value(9, false)  # Disable pink wall collision
	
	print("Player color: ", current_color)
	print("Collision mask: ", collision_mask)
	collision_mask = 1  # Only layer 1 (platforms) is on by default
	
	match current_color:
		PlayerColor.RED:
			color_rect.color = Color(1, 0, 0, 1)
			set_collision_mask_value(2, false)  # Can pass through red walls
		PlayerColor.BLUE:
			color_rect.color = Color(0, 0, 1, 1)
			set_collision_mask_value(3, false)  # Can pass through blue walls
		PlayerColor.YELLOW:
			color_rect.color = Color(1, 1, 0, 1)
			set_collision_mask_value(4, false)  # Can pass through yellow walls
		PlayerColor.GREEN:
			color_rect.color = Color(0, 1, 0, 1)
			set_collision_mask_value(5, false)  # Can pass through green walls
		PlayerColor.PURPLE:
			color_rect.color = Color(0.5, 0, 0.5, 1)
			set_collision_mask_value(6, false)  # Can pass through purple walls
		PlayerColor.ORANGE:
			color_rect.color = Color(1, 0.5, 0, 1)
			set_collision_mask_value(7, false)  # ← ADD THIS! Can pass through orange walls
		PlayerColor.WHITE:
			color_rect.color = Color(1, 1, 1, 1)
			set_collision_mask_value(8, false)  # Can pass through white walls
		PlayerColor.PINK:
			color_rect.color = Color(1, 0.4, 0.7, 1)
			set_collision_mask_value(9, false)  # Can pass through pink walls
	collision_mask = -1
	match current_color:
		PlayerColor.BLUE:
			color_rect.color = Color(0, 0, 1, 1)
			set_collision_mask_value(3, false)
		PlayerColor.RED:
			color_rect.color = Color(1, 0, 0, 1)
			set_collision_mask_value(2, false)
		PlayerColor.YELLOW:
			color_rect.color = Color(1, 1, 0, 1)
			set_collision_mask_value(4, false)
		PlayerColor.GREEN:
			color_rect.color = Color(0, 1, 0, 1)
			set_collision_mask_value(5, false)
		PlayerColor.PURPLE:
			color_rect.color = Color(0.5, 0, 0.5, 1)
			set_collision_mask_value(6, false)
		PlayerColor.ORANGE:
			color_rect.color = Color(1, 0.5, 0, 1)
			set_collision_mask_value(7, false)
		PlayerColor.WHITE:
			color_rect.color = Color(1, 1, 1, 1)
			set_collision_mask_value(8, false)
		PlayerColor.PINK:
			color_rect.color = Color(1, 0.4, 0.7, 1)
			set_collision_mask_value(9, false)

func add_color(color: PlayerColor) -> void:
	match current_color:
		PlayerColor.RED:
			match color:
				PlayerColor.BLUE:
					current_color = PlayerColor.PURPLE
				PlayerColor.YELLOW:
					current_color = PlayerColor.ORANGE
				PlayerColor.WHITE:
					current_color = PlayerColor.PINK
		PlayerColor.BLUE:
			match color:
				PlayerColor.RED:
					current_color = PlayerColor.PURPLE
				PlayerColor.YELLOW:
					current_color = PlayerColor.GREEN
		PlayerColor.YELLOW:
			match color:
				PlayerColor.RED:
					current_color = PlayerColor.ORANGE
				PlayerColor.BLUE:
					current_color = PlayerColor.GREEN
		PlayerColor.WHITE:
			match color:
				PlayerColor.RED:
					current_color = PlayerColor.PINK
	update_color()

func subtract_color(color: PlayerColor) -> void:
	match current_color:
		PlayerColor.PURPLE:
			match color:
				PlayerColor.RED:
					current_color = PlayerColor.BLUE
				PlayerColor.BLUE:
					current_color = PlayerColor.RED
		PlayerColor.ORANGE:
			match color:
				PlayerColor.RED:
					current_color = PlayerColor.YELLOW
				PlayerColor.YELLOW:
					current_color = PlayerColor.RED
		PlayerColor.GREEN:
			match color:
				PlayerColor.BLUE:
					current_color = PlayerColor.YELLOW
				PlayerColor.YELLOW:
					current_color = PlayerColor.BLUE
		PlayerColor.PINK:
			match color:
				PlayerColor.WHITE:
					current_color = PlayerColor.RED
				PlayerColor.RED:
					current_color = PlayerColor.WHITE
	update_color()
