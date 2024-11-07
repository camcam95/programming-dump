extends Node

enum Tetromino{
	I, O, T, J, L, Z, S
}

var cells = {
	Tetromino.I : [Vector2(-1, 0), Vector2(0, 0), Vector2(1, 0), Vector2(2, 0)],
	Tetromino.J : [Vector2(-1, 1), Vector2(-1, 0), Vector2(0, 0), Vector2(1, 0)],
	Tetromino.L : [Vector2(1, 1), Vector2(-1, 0), Vector2(0, 0), Vector2(1, 0)],
	Tetromino.O : [Vector2(0, 1), Vector2(1, 1), Vector2(0, 0), Vector2(1, 0)],
	Tetromino.S : [Vector2(0, 1), Vector2(1, 1), Vector2(-1, 0), Vector2(0, 0)],
	Tetromino.T : [Vector2(0, 1), Vector2(-1, 0), Vector2(0, 0), Vector2(1, 0)],
	Tetromino.Z : [Vector2(-1, 1), Vector2(0, 1), Vector2(0, 0), Vector2(1, 0)],
}

# " A wall kick happens when a player rotates a piece when no space exists in the squares where that tetromino would normally occupy after the rotation.
#   To compensate, the game sets a certain number of alternative spaces for the tetromino to look.
#   Wall kicks started appearing in games because after a piece would be backed up against the wall, it would awkwardly be unable to rotate until first moving back. "

var wall_kicks_i = [
	[Vector2(0,0), Vector2(-2,0), Vector2(1,0), Vector2(-2,-1), Vector2(1,2)],
	[Vector2(0,0), Vector2(2,0), Vector2(-1, 0), Vector2(2,1), Vector2(-1, -2)],
	[Vector2(0,0), Vector2(-1, 0), Vector2(2,0), Vector2(-1,2), Vector2(2, -1)],
	[Vector2(0,0), Vector2(1,0), Vector2(-2, 0), Vector2(1, -2), Vector2(-2, 1)],
	[Vector2(0,0), Vector2(2,0), Vector2(-1, 0), Vector2(2,1), Vector2(-1, -2)],
	[Vector2(0,0), Vector2(-2,0), Vector2(1, 0), Vector2(-2, -1), Vector2(1, 2)],
	[Vector2(0,0), Vector2(1,0), Vector2(-2,0), Vector2(1, -2), Vector2(-2,1)],
	[Vector2(0,0), Vector2(-1, 0), Vector2(2, 0), Vector2(-1,2), Vector2(2, -1)]
]

var wall_kicks_jlostz = [
	[Vector2(0,0), Vector2(-1,0), Vector2(-1,1), Vector2(0,-2), Vector2(-1, -2)],
	[Vector2(0,0), Vector2(1,0), Vector2(1, -1), Vector2(0,2), Vector2(1, 2)],
	[Vector2(0,0), Vector2(1, 0), Vector2(1,-1), Vector2(0,2), Vector2(1, 2)],
	[Vector2(0,0), Vector2(-1,0), Vector2(-1, 1), Vector2(0, -2), Vector2(-1, -2)],
	[Vector2(0,0), Vector2(1,0), Vector2(1, 1), Vector2(0,-2), Vector2(1, -2)],
	[Vector2(0,0), Vector2(-1,0), Vector2(-1, -1), Vector2(0, 2), Vector2(-1, 2)],
	[Vector2(0,0), Vector2(-1,0), Vector2(-1,-1), Vector2(0, 2), Vector2(-1, 2)],
	[Vector2(0,0), Vector2(1, 0), Vector2(1, 1), Vector2(0,-2), Vector2(1, -2)]
]

var data = {
	Tetromino.I: preload("res://resources/i_piece_data.tres"),
	Tetromino.J: preload("res://resources/j_piece_data.tres"),
	Tetromino.L: preload("res://resources/l_piece_data.tres"),
	Tetromino.O: preload("res://resources/o_piece_data.tres"),
	Tetromino.S: preload("res://resources/s_piece_data.tres"),
	Tetromino.T: preload("res://resources/t_piece_data.tres"),
	Tetromino.Z: preload("res://resources/z_piece_data.tres")
}

var clockwise_rotation_matrix = [Vector2(0, -1), Vector2(1, 0)]
var counter_clockwise_rotation_matrix = [Vector2(0, 1), Vector2(-1, 0)]
