extends CanvasLayer
signal start_game

#funcion para mostrar un mensaje
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

#esta funcion la hacemos para luego del game over nos envie nuevamente a la pantalla principal y podamos jugar nuevamente
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Dodge the Creeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
#Este actualizara la puntuacion en pantalla
func update_score(score):
	$ScoreLabel.text = str(score)



func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()


func _on_message_timer_timeout() -> void:
	$Message.hide()
