extends Node2D

func _ready() -> void:
	$Items.hide()
	$Player.reset($SpawnPoint.position)
