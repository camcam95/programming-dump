extends Node2D

var g = 0 # Ground
var w = 1 # Walls
var	c = 2 # Crates
var e = 3 # Goals

var spawn = [1, 1]

var design = [
	[w, w, w, w, w, g, g],
	[w, g, g, g, w, g, g],
	[w, g, w, g, w, w, w],
	[w, g, g, g, g, g, w],
	[w, w, w, w, w, w, w]
]
