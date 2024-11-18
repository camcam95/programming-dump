extends Pawn

@onready var Level = get_parent()
var lost : bool = false
var cellSize : int = 64

func _ready() -> void:
	update_look_direction(Vector2.RIGHT)
	

func _process(delta: float) -> void:
	var input_direction = get_input_direction()
	if not input_direction:
		return
	update_look_direction(input_direction)
	
	var target_position = Level.request_move(self, input_direction)
	if target_position:
		move_to(target_position)
		$Tween.start()
	else:
		bump()
		
func get_input_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)

func update_look_direction(direction) -> void:
	$Pivot/Sprite.rotation = direction.angle()
	
func move_to(target_position) -> void:
	set_process(false)
	$AnimationPlayer.play("walk")
	var move_direction = (position - target_position).normalized()
	$Tween.interpolate_property($Pivot, "position", move_direction * cellSize, Vector2(), $AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Pivot/Sprite.position = position - target_position
	position = target_position
	
	await $AnimationPlayer.animation_finished
	
	set_process(true)
	
func bump() -> void:
	$AnimationPlayer.play("bump")
