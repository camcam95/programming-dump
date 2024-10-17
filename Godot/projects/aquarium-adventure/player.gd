extends Area2D

@export var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimatedSprite2D.play()
	
	# Check for input
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1 
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	
	# Move in the given direction
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	# Play the correct animation
	if velocity.x == 0 and velocity.y == 0:
		$AnimatedSprite2D.animation = "still"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = false
	elif velocity.x != 0:
		$AnimatedSprite2D.animation = "moving"
		$AnimatedSprite2D.flip_h = velocity.x < 0
		
