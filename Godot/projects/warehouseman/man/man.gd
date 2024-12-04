extends Area2D

var screenSize : Vector2

func _ready() -> void:
	screenSize = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("ui_up"):
		if position.y >= 0:
			tween_move(Vector2.UP)
	if Input.is_action_just_pressed("down") or Input.is_action_just_pressed("ui_down"):
		if position.y <= (screenSize.y - $Sprite2D.get_rect().size.y):
			tween_move(Vector2.DOWN)
	if Input.is_action_just_pressed("right") or Input.is_action_just_pressed("ui_right"):
		if position.x >= 0:
			tween_move(Vector2.RIGHT)
	if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("ui_left"):
		if position.x <= (screenSize.x - $Sprite2D.get_rect().size.x):
			tween_move(Vector2.LEFT)		
			
func tween_move(direction : Vector2) -> void:
	#TODO: tween the move $Sprite2D.get_rect().size
	pass
