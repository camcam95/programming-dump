extends RigidBody2D

var speed = 400
var size = Vector2(1, 1)

func _process(delta: float) -> void:
	scale = size
	$CollisionShape2D.scale = size
	var velocity = Vector2(0, 1)
	velocity = velocity.normalized() * speed
	position += velocity * delta
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free
