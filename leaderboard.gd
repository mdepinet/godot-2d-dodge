extends CanvasLayer

signal leaderboard_closed

var LEADERBOARD_FILE = "user://leaderboard.txt"
var MAX_SCORES = 6

var scores = []

func _init():
	var file = FileAccess.open(LEADERBOARD_FILE, FileAccess.READ)
	if file == null:
		return
	scores.clear()
	while file.get_position() < file.get_length():
		var line = file.get_csv_line()
		scores.append(line)

func is_high_score(score):
	return scores.is_empty() or score > int(scores[-1][1])

func add_score(name, score):
	if not is_high_score(score):
		return
	var array = PackedStringArray([name, str(score)])
	if scores.is_empty():
		scores.append(array)
	else:
		for i in range(min(scores.size(), MAX_SCORES)):
			if score > int(scores[i][1]):
				scores.insert(i, array)
				break
		if (scores.size() > MAX_SCORES):
			scores.resize(MAX_SCORES)
	render()
	persist_leaderboard()
	
func render():
	for child in $ScrollContainer/VBoxContainer.get_children():
		child.queue_free()
	for score in scores:
		var button = Button.new()
		button.text = " - ".join(score)
		$ScrollContainer/VBoxContainer.add_child(button)

func persist_leaderboard():
	var file = FileAccess.open(LEADERBOARD_FILE, FileAccess.WRITE)
	for score in scores:
		file.store_csv_line(score)
	file.flush()

func _ready():
	render()

func _on_button_pressed():
	leaderboard_closed.emit()
