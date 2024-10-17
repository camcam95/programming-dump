# FAUXTRIS - A fake Tetris
# Piece Names:
# ___| - Orange Ricky
# |___ - Blue Ricky
# ‾|_  - Cleveland Z
# _|‾  - Rhode Island Z
#  |   - Hero
# _|_  - Teewee
#  □   - Smashboy

extends Node

@export var orange_ricky_scene : PackedScene
@export var blue_ricky_scene : PackedScene
@export var cleveland_z_scene : PackedScene
@export var rhode_island_z_scene : PackedScene
@export var hero_scene : PackedScene
@export var teewee_scene : PackedScene
@export var smashboy_scene : PackedScene

@export var speed : int = 400

var cells : Array
var cellsize

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass
