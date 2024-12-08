extends Area2D

signal hit

enum {ALIVE, DEAD}
var state = ALIVE

#NOTE: Eventually will contain 3 possible items: coin, diamond, shroom
#NOTE: If it's coin, set an amount

func _on_body_entered(body: Node2D) -> void:
	print("boop")
	if state == ALIVE:
		hit.emit()
		change_state(DEAD)
		print("beep")
		
func change_state(new_state):
	state = new_state
	match state:
		ALIVE:
			$Sprite2D.frame_coords = Vector2(4, 0)
		DEAD:
			$Sprite2D.frame_coords = Vector2(4, 1)
