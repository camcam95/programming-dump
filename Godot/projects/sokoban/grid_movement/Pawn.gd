class_name Pawn
extends Node2D

@export var type : CellType = CellType.ACTOR

enum CellType { ACTOR, OBSTACLE, OBJECT }

var active = true : set = set_active

func set_active(value):
	active = value
	set_process(value)
	set_process_input(value)
