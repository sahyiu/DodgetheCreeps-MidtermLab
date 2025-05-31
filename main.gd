extends Node

@export var Mob: PackedScene
var score = 0

func _ready():
	randomize()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.game_over()
	$DeathSound.play()
	$Music.stop()
	
func new_game():
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.show_message("Get Ready")
	$HUD.update_score(score)
	$Music.play()
	
func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
	
func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.progress_ratio = randf()
	var mob = Mob.instantiate()
	add_child(mob)
	var direction = $MobPath/MobSpawnLocation.rotation
	mob.position = $MobPath/MobSpawnLocation.position
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	mob.set_linear_velocity(Vector2(randf_range(mob.MIN_SPEED, mob.MAX_SPEED), 0).rotated(direction))
	


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_Player_hit() -> void:
	game_over()
