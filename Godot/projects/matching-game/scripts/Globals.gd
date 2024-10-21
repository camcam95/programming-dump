extends Node

enum tile_icons {
	alien, 
	bat, 
	candycorn, castle, cauldron, 
	devil, 
	hand, 
	knife, 
	owl, 
	potion, pumpkin, 
	scarecrow, skull, 
	zombie 
}

var data = {
	tile_icons.alien: preload("res://assets/tiles/alien.svg"),
	tile_icons.bat: preload("res://assets/tiles/bat.svg"),
	tile_icons.candycorn: preload("res://assets/tiles/candycorn.svg"),
	tile_icons.castle: preload("res://assets/tiles/castle.svg"),
	tile_icons.cauldron: preload("res://assets/tiles/cauldron.svg"),
	tile_icons.devil: preload("res://assets/tiles/devil.svg"),
	tile_icons.hand: preload("res://assets/tiles/hand.svg"),
	tile_icons.knife: preload("res://assets/tiles/knife.svg"),
	tile_icons.owl: preload("res://assets/tiles/owl.svg"),
	tile_icons.potion: preload("res://assets/tiles/potion.svg"),
	tile_icons.pumpkin: preload("res://assets/tiles/pumpkin.svg"),
	tile_icons.scarecrow: preload("res://assets/tiles/scarecrow.svg"),
	tile_icons.skull: preload("res://assets/tiles/skull.svg"),
	tile_icons.zombie: preload("res://assets/tiles/zombie.svg")
}

var tile_size := 40
var gap_size := 10
var screen_width := 640
var screen_height := 480
