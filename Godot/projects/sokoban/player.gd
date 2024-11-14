extends CharacterBody2D

var screenSize : Vector2
var cellSize : int = 64
var canMove : bool = true

func _ready() -> void:
	screenSize = get_viewport_rect().size
	

func _process(delta: float) -> void:
	if canMove == true:
		if Input.is_action_just_pressed("up") and position.y > cellSize:
			locamote(Vector2.UP)
		if Input.is_action_just_pressed("down") and position.y < screenSize.y - cellSize:
			locamote(Vector2.DOWN)
		if Input.is_action_just_pressed("left") and position.x > cellSize:
			locamote(Vector2.LEFT)
		if Input.is_action_just_pressed("right") and position.x < screenSize.x - cellSize:
			locamote(Vector2.RIGHT)
	

func locamote(dir: Vector2):
	# At some point, I'll need to test what (wall, crate) is in the immediate cardinal directions from the player
	# For now, I just move and tween said move.
	
	canMove = false
	var tween = create_tween()
	tween.tween_property(self, "position", position + dir * cellSize, 0.2).set_trans(Tween.TRANS_QUINT)
	await tween.finished
	canMove = true
