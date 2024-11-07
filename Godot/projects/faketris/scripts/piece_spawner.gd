extends Node

var current_tetromino

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_tetromino = Globals.Tetromino.values().pick_random()
