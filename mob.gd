extends RigidBody2D

@export var MIN_SPEED: int = 150
@export var MAX_SPEED: int = 250

var mob_types = ["fly", "swim","walk"]

func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.animation = mob_types[randi() % mob_types.size()]


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
