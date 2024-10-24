extends Area2D

signal hit

@export var speed : int = 400
var screen_size : Vector2
var player_size : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	position.x = screen_size.x / 2
	position.y = screen_size.y - 60
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.x == 0:
		$AnimatedSprite2D.animation = "idle"
			
	position += velocity * delta
	position = position.clamp(Vector2(22, 0), Vector2(screen_size.x - 22, screen_size.y))


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
