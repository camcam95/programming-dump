extends CharacterBody2D

signal life_changed
signal died

@export var gravity = 750
@export var run_speed = 130
@export var jump_speed = -300 # -y = up

enum {IDLE, RUN, JUMP, HURT, DEAD}
var state = IDLE
var life = 3: set = set_life

func _ready() -> void:
	change_state(IDLE)
	
func change_state(new_state):
	state = new_state
	match state:
		IDLE:
			$AnimationPlayer.play("idle")
		RUN:
			$AnimationPlayer.play("run")
		JUMP:
			$AnimationPlayer.play("jump_up")
		HURT:
			$AnimationPlayer.play("hurt")
			# Bouncing up and away
			velocity.y = -200
			velocity.x = -100 * sign(velocity.x)
			life -= 1
			await get_tree().create_timer(0.5).timeout
			change_state(IDLE)
		DEAD:
			died.emit()
			hide()
	
func get_input():
	if state == HURT:
		return
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_just_pressed("jump")

	# Each if counts one of the transitions in the FSM
	velocity.x = 0
	if right:
		velocity.x += run_speed
		$Sprite2D.flip_h = false
	if left:
		velocity.x -= run_speed
		$Sprite2D.flip_h = true
	# Only allow jump if on ground
	if jump and is_on_floor():
		change_state(JUMP)
		velocity.y = jump_speed
	# IDLE transition to RUN
	if state == IDLE and velocity.x != 0:
		change_state(RUN)
	# RUN transition to IDLE
	if state == RUN and velocity.x == 0:
		change_state(IDLE)
	# JUMP transition when in air
	if state in [IDLE, RUN] and !is_on_floor():
		change_state(JUMP)

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	get_input()
	
	move_and_slide()
	if state == JUMP and is_on_floor():
		change_state(IDLE)
	if state == JUMP and velocity.y > 0:
		$AnimationPlayer.play("jump_down")
		
func reset(_position):
	position = _position
	life = 3
	show()
	change_state(IDLE)

func set_life(value):
	life = value
	life_changed.emit(life)
	if life <= 0:
		change_state(DEAD)

func hurt():
	if state != HURT:
		change_state(HURT)