extends CanvasLayer

signal reset

func _on_restart_button_pressed() -> void:
	reset.emit()
