extends CanvasLayer

signal clicked
var cell : Vector2

func _on_button_pressed() -> void:
	clicked.emit()
	print($Button.text)
