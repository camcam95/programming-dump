extends Area2D

var screensize = Vector2.ZERO

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


func _on_lifetime_timeout() -> void:
	queue_free()
