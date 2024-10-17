extends Node

@export var snake_scene : PackedScene

# Game Variables
var score : int
var game_started : bool = false

# Grid Variables
var cells : int = 20
var cell_size : int = 50

# Snake Variables
var old_data : Array # Previous coordinates
var snake_data : Array # Snake segment locations
var snake : Array # Snake segment scenes

# Movement Variables
var start_pos := Vector2(9, 9)
var up := Vector2(0, -1)
var down := Vector2(0, 1)
var left := Vector2(-1, 0)
var right := Vector2(1, 0)
var move_direction : Vector2
var can_move : bool

# Food Variables
var food_pos : Vector2
var regen_food : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()
	
# Resets game	
func new_game() -> void:
	get_tree().paused = false
	# Remove previous snake
	get_tree().call_group("segments", "queue_free")
	$GameOverMenu.hide()
	score = 0
	$HUD.get_node("ScoreLabel").text = "SCORE: " + str(score)
	move_direction = up
	can_move = true
	generate_snake()
	move_food()
	
func generate_snake() -> void:
	old_data.clear()
	snake_data.clear()
	snake.clear()
	# Starting with start_pos, create segments vertically down
	for i in range(3):
		add_segment(start_pos + Vector2(0, i))
	
func add_segment(pos) -> void:
	snake_data.append(pos)
	var SnakeSegment = snake_scene.instantiate()
	SnakeSegment.position = (pos * cell_size) + Vector2(0, cell_size)
	add_child(SnakeSegment)
	snake.append(SnakeSegment)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_snake()
	
func move_snake() -> void:
	if can_move:
		if Input.is_action_just_pressed("move_up") and move_direction != down:
			move_direction = up
			can_move = false
			if not game_started:
				start_game()
		if Input.is_action_just_pressed("move_down") and move_direction != up:
			move_direction = down
			can_move = false
			if not game_started:
				start_game()
		if Input.is_action_just_pressed("move_left") and move_direction != right:
			move_direction = left
			can_move = false
			if not game_started:
				start_game()
		if Input.is_action_just_pressed("move_right") and move_direction != left:
			move_direction = right
			can_move = false
			if not game_started:
				start_game()
				
func start_game() -> void:
	game_started = true
	$MoveTimer.start()


func _on_move_timer_timeout() -> void:
	# Reallow movement
	can_move = true
	# Use snake's previous position to move each segment
	old_data = [] + snake_data
	snake_data[0] += move_direction
	for i in range(len(snake_data)):
		if i > 0:
			snake_data[i] = old_data[i - 1]
		snake[i].position = (snake_data[i] * cell_size) + Vector2(0, cell_size)
	check_out_of_bounds()
	check_self_eaten()
	check_food_eaten()
	
func check_out_of_bounds():
	# Check position of snakes head (snake[0]) and make sure it's on screen
	if snake_data[0].x < 0 or snake_data[0].x > cells - 1 or snake_data[0].y < 0 or snake_data[0].y > cells - 1:
		end_game()
		
func check_self_eaten():
	# Check if any segment is in the same cell as the head
	for i in range(1, len(snake_data)):
		if snake_data[0] == snake_data[i]:
			end_game()
		
func move_food():
	# Generate food while also making sure it doesn't generate in a cell with a snake segment in it
	while regen_food:
		regen_food = false
		food_pos = Vector2(randi_range(0, cells - 1), randi_range(0, cells - 1))
		for i in snake_data:
			if food_pos == i:
				regen_food = true
	$Food.position = (food_pos * cell_size) + Vector2(0, cell_size)
	regen_food = true
			
func check_food_eaten():
	if snake_data[0] == food_pos:
		score += 1
		$HUD.get_node("ScoreLabel").text = "SCORE: " + str(score)
		add_segment(old_data[-1])
		move_food()
	
func end_game():
	$GameOverMenu.show()
	$MoveTimer.stop()
	game_started = false
	get_tree().paused = true


func _on_game_over_menu_restart() -> void:
	new_game()
