extends CanvasLayer

signal start_game

func show_message(text: String = ""):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func game_over():
	show_message("Game Over")
	await $MessageTimer.timeout
	$StartButton.show()
	$MessageLabel.text = "Dodge the\nCreeps!!!"
	$MessageLabel.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)
	
func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_StartButton_pressed() -> void:
	$StartButton.hide()
	emit_signal("start_game")
