extends Node

@export var mob_scene: PackedScene
var score

var SPEED_GROWTH_RATE = 4

func game_over():
	$ScoreTimer.stop()
	$SpawnTimer.stop()
	$HUD.show_game_over()
	$BGMusic.stop()
	$GameOverSound.play()

func new_game():
	score = 0
	get_tree().call_group("Creeps", "queue_free")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$BGMusic.play()

func _on_start_timer_timeout():
	$SpawnTimer.start()
	$ScoreTimer.start()

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_spawn_timer_timeout():
	if (not should_spawn()):
		return
	var mob = mob_scene.instantiate()
	var spawn_loc = $MobPath/SpawnLocation
	spawn_loc.progress_ratio = randf()
	while spawn_loc.position.distance_to($Player.position) < 100:
		spawn_loc.progress_ratio = randf()
	mob.position = spawn_loc.position
	var direction = spawn_loc.rotation + PI/2
	direction += randf_range(-PI/4, PI/4)
	mob.rotation = direction
	var velocity = Vector2(randf_range(150.0, 250.0) + SPEED_GROWTH_RATE * score, 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	add_child(mob)

func should_spawn():
	if (get_tree().get_nodes_in_group("Creeps").is_empty()):
		return true
	return randi_range(0, 100) - 25 < score
