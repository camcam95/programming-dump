extends Area2D

signal pickup
signal hurt

@export var speed = 350
var velocity = Vector2.ZERO
var screensize = Vector2(480, 720)

func _process(delta: float) -> void:
	# Built-in that returns direction vector
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	position += velocity * speed * delta
	position = position.clamp(Vector2.ZERO, screensize)
	
	if velocity.length() > 0:
		$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.animation = "idle"
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
		

func start():
	# Allows _process to run
	set_process(true)
	position = screensize / 2
	$AnimatedSprite2D.animation = "idle"
	
func die():
	$AnimatedSprite2D.animation = "hurt"
	# Stops _process from running
	set_process(false)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("coins"):
		area.pickup()
		pickup.emit("coin")
	if area.is_in_group("obstacles"):
		hurt.emit()
		die()
	if area.is_in_group("powerups"):
		area.pickup()
		pickup.emit("powerup")