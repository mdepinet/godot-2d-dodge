extends CanvasLayer

signal start_game

var score = 0

func _ready():
	$Leaderboard.hide()
	$NameEntry.hide()

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_initial_state():
	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	await get_tree().create_timer(1.0).timeout
	$ButtonRow.show()

func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout
	if $Leaderboard.is_high_score(score):
		$ScoreLabel.hide()
		$NameEntry.show()
		$NameEntry/Name.grab_focus()
	else:
		show_initial_state()

func _on_name_submitted(name):
	$NameEntry.hide()
	$Leaderboard.add_score(name, score)
	$Leaderboard.show()

func _on_leaderboard_closed():
	$Leaderboard.hide()
	$ScoreLabel.show()
	show_initial_state()

func update_score(score):
	self.score = score
	$ScoreLabel.text = str(score)

func _on_message_timer_timeout():
	$Message.hide()

func _on_start_button_pressed():
	$ButtonRow.hide()
	start_game.emit()


func _on_leaderboard_button_pressed():
	$ButtonRow.hide()
	$ScoreLabel.hide()
	$Message.hide()
	$Leaderboard.show()
