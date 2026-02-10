extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const COYOTE_TIME = 0.1

enum PlayerColor { RED, BLUE }
var current_color: PlayerColor = PlayerColor.RED
var coyote_timer: float = 0.0

@onready var color_rect = $ColorRect

func _ready():
	update_color()
	set_collision_mask_value(2, false)  # Red walls
	set_collision_mask_value(3, true)   # Blue walls

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
		toggle_color()
	
	# Get input direction and handle movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func toggle_color():
	if current_color == PlayerColor.RED:
		current_color = PlayerColor.BLUE
	else:
		current_color = PlayerColor.RED
	update_color()

func update_color():
	if current_color == PlayerColor.RED:
		color_rect.color = Color(1, 0, 0, 1)  # Red
		set_collision_mask_value(2, false)  # Pass through red walls
		set_collision_mask_value(3, true)   # Collide with blue walls
	else:
		color_rect.color = Color(0, 0, 1, 1)  # Blue
		set_collision_mask_value(2, true)   # Collide with red walls
		set_collision_mask_value(3, false)  # Pass through blue walls
