extends CanvasLayer

signal start_pressed

func _on_start_button_pressed() -> void:
	start_pressed.emit()
