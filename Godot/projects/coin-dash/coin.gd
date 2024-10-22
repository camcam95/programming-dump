extends Area2D

var screensize = Vector2.ZERO

func _ready() -> void:
	$Timer.start(randf_range(3, 8))

func pickup():
	# Disable Collision, but wait until end of frame (set_deferred)
	$CollisionShape2D.set_deferred("disabled", true)
	# Tweening || Easing - https://www.easing.net/
	# set_parallel makes sure if another tween happens, they happen at the same time
	# set_trans: Choose your transition curve to follow
	var tw = create_tween().set_parallel().set_trans(Tween.TRANS_QUAD)
	# Tweens have properties...
	tw.tween_property(self, "scale", scale * 3, 0.3)
	tw.tween_property(self, "modulate:a", 0.0, 0.3)
	await tw.finished
	queue_free()


func _on_timer_timeout() -> void:
	$AnimatedSprite2D.frame = 0
	$AnimatedSprite2D.play()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("obstacles"):
		position = Vector2(randi_range(0, screensize.x), randi_range(0, screensize.y))
	if area.is_in_group("powerups"):
		position = Vector2(randi_range(0, screensize.x), randi_range(0, screensize.y))
