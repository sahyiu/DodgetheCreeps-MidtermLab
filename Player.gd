extends Area2D

signal hit

var is_alive = true
var speed = 300
var velocity = Vector2.ZERO

func _process(delta):
	if not is_alive:
		return

	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	position += velocity * delta

func _on_Player_body_entered(_body):
	if not is_alive:
		return
	print("Player hit detected by", _body.name)  # Debug print!
	is_alive = false
	emit_signal("hit")
	hide()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	is_alive = true
	$CollisionShape2D.disabled = false


func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
