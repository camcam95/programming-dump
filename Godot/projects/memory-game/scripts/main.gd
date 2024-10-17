extends Node

@export var board_piece_scene : PackedScene

var difficulty
var base_pairs : int = 4
var board : Array
var cell_size = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_gui_start_pressed() -> void:
	start_game()
	
func start_game():
	difficulty = $StartGUI/Background/ItemList.get_selected_items()
	difficulty = difficulty[0]
	generate_board(difficulty)
	$StartGUI.hide()
	
func generate_board(diff):
	# Difficulty cases
	match diff:
		0:
			board_piece_creation(base_pairs + (diff * 1))
		1:
			board_piece_creation(base_pairs + (diff * 2))
		2:
			board_piece_creation(base_pairs + (diff * 3))
	
	# Give each board piece a cell vector	
	for i in range(0, board.size()):
		for j in range(0, board.size()):
			board[i].get_node("Button").text = str(i)
			board[i].cell = Vector2(i, j)
		
	# Place each piece in its cell
	for i in range(0, board.size()):
		board[i].get_node("Button").position = Vector2(board[i].cell.x * cell_size + 10, board[i].cell.y * cell_size + 10)

func board_piece_creation(amount):
	for x in range(0, amount):
		var board_piece = board_piece_scene.instantiate()
		board.append(board_piece)
		var board_piece2 = board_piece_scene.instantiate()
		board.append(board_piece2)
		add_child(board_piece)
		add_child(board_piece2)
