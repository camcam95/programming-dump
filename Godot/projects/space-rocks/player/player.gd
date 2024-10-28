extends RigidBody2D

signal lives_changed
signal dead
signal shield_changed

var reset_pos = false
var lives = 0: set = set_lives

@export var bullet_scene : PackedScene
@export var fire_rate = 0.25
var can_shoot = true

@export var max_shield = 100.0
@export var shield_regen = 5.0
var shield = 0: set = set_shield

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
			$Sprite2D.modulate.a = 0.5
		ALIVE:
			$CollisionShape2D.set_deferred("disabled", false)
			$Sprite2D.modulate.a = 1.0
		INVULNERABLE:
			$CollisionShape2D.set_deferred("disabled", true)
			$Sprite2D.modulate.a = 0.5
			$InvulnerabilityTimer.start()
		DEAD:
			$CollisionShape2D.set_deferred("disabled", true)
			$Sprite2D.hide()
			linear_velocity = Vector2.ZERO
			dead.emit()
			$EngineSound.stop()
	state = new_state

func _process(delta: float) -> void:
	get_input()
	shield += shield_regen * delta
	
func get_input():
	$Exhaust.emitting = false
	thrust = Vector2.ZERO
	# If dead or none existant, leave
	if state in [DEAD,INIT]:
		return
	if Input.is_action_pressed("thrust"):
		$Exhaust.emitting = true
		thrust = transform.x * engine_power
		if not $EngineSound.playing:
			$EngineSound.play()
	else:
		$EngineSound.stop()
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
	$LaserSound.play()

func _on_gun_cooldown_timeout() -> void:
	can_shoot = true

func set_lives(value):
	lives = value
	lives_changed.emit(lives)
	if lives <= 0:
		change_state(DEAD)
	else:
		change_state(INVULNERABLE)
	shield = max_shield
	
func reset():
	reset_pos = true
	$Sprite2D.show()
	lives = 3
	change_state(ALIVE)


func _on_invulnerability_timer_timeout() -> void:
	change_state(ALIVE)


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("rocks"):
		shield -= body.size * 25
		body.explode()
		

func explode():
	$Explosion.show()
	$Explosion/AnimationPlayer.play("explosion")
	await $Explosion/AnimationPlayer.animation_finished
	$Explosion.hide()

func set_shield(value):
	value = min(value, max_shield) # To make sure regen doesn't cause the shield to go over max
	shield = value
	shield_changed.emit(shield / max_shield) # To give HUD a % and it not needing to know how big the shield is in the first place
	if shield <= 0:
		lives -= 1
		explode()
