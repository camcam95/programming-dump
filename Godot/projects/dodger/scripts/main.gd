# TODO : Still working on projectiles spawning and falling properly

extends Node

@export var sawblade_scene : PackedScene

var score : int
var game_started : bool = false
var projectiles : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

func new_game() -> void:
	get_tree().paused = false
	get_tree().call_group("Projectiles", "queue_free")
	$GameOverMenu.hide()
	score = 0
	$HUD/ScoreLabel.text = "SCORE: 0"
	$ProjectileTimer.start()
	$ScoreTimer.start()
	$Player.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spawn_projectile():
	var size = randf_range(1, 3)
	var pos = Vector2(randi_range(0, 480), 0)
	var Sawblade = sawblade_scene.instantiate()
	Sawblade.position = pos
	Sawblade.size = Vector2(size, size)
	projectiles.append(Sawblade)
	add_child(Sawblade)

func _on_projectile_timer_timeout() -> void:
	spawn_projectile()


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD/ScoreLabel.text = "Score: " + str(score)


func _on_game_over_reset() -> void:
	new_game() # Replace with function body.


func _on_player_hit() -> void:
	get_tree().call_group("Projectiles", "queue_free")
	end_game()
	
func end_game() -> void:
	get_tree().paused = true
	$GameOverMenu.show()
	$ProjectileTimer.stop()
	$ScoreTimer.stop()
