extends RigidBody2D

signal lives_changed
signal dead

var reset_pos = false
var lives = 0: set = set_lives

@export var bullet_scene : PackedScene
@export var fire_rate = 0.25
var can_shoot = true

@export var engine_power = 500
@export var spin_power = 8000

var screensize := Vector2.ZERO
var thrust := Vector2.ZERO
var rotation_dir = 0

# Possible states
enum {INIT, ALIVE, INVULNERABLE, DEAD}
var state = INIT

func _ready() -> void:
	screensize = get_viewport_rect().size
	change_state(ALIVE)
	$GunCooldown.wait_time = fire_rate

func change_state(new_state):
	match new_state:
		INIT:
			$CollisionShape2D.set_deferred("disabled", true)
		ALIVE:
			$CollisionShape2D.set_deferred("disabled", false)
		INVULNERABLE:
			$CollisionShape2D.set_deferred("disabled", true)
		DEAD:
			$CollisionShape2D.set_deferred("disabled", true)
	state = new_state

func _process(delta: float) -> void:
	get_input()
	
func get_input():
	thrust = Vector2.ZERO
	# If dead or none existant, leave
	if state in [DEAD,INIT]:
		return
	if Input.is_action_pressed("thrust"):
		thrust = transform.x * engine_power
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()
	rotation_dir = Input.get_axis("rotate_left", "rotate_right")
	
func _physics_process(delta: float) -> void:
	constant_force = thrust
	constant_torque = rotation_dir * spin_power

# Screen Wraping
func _integrate_forces(physics_state: PhysicsDirectBodyState2D) -> void:
	var xform = physics_state.transform
	# wrapf is like a vector clamp but for whatever the first argument is.
	xform.origin.x = wrapf(xform.origin.x, 0, screensize.x)
	xform.origin.y = wrapf(xform.origin.y, 0, screensize.y)
	physics_state.transform = xform
	
	if reset_pos:
		physics_state.transform.origin = screensize / 2
		reset_pos = false

func shoot():
	# Can't shoot if you're a ghost
	if state == INVULNERABLE:
		return
	can_shoot = false
	$GunCooldown.start()
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start($Muzzle.global_transform)


func _on_gun_cooldown_timeout() -> void:
	can_shoot = true

func set_lives(value):
	lives = value
	lives_changed.emit(lives)
	if lives <= 0:
		change_state(DEAD)
	else:
		change_state(INVULNERABLE)
		
func reset():
	reset_pos = true
	$Sprite2D.show()
	lives = 3
	change_state(ALIVE)