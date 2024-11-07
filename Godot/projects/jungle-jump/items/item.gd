extends Area2D

signal picked_up

var textures = {
	"cherry" : "res://assets/sprites/cherry.png",
	"gem" : "res://assets/sprites/gem.png"
}

func _init(type, _position) -> void:
	$Sprite2D.texture = load(textures[type])
	position = _position


func _on_item_body_entered(body: Node2D) -> void:
	picked_up.emit()
	queue_free()
