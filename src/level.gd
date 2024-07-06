extends Node3D
class_name TacticsLevel

var t_from = null
var t_to = null
var curr_t = null
var player : TacticsPlayerController = null
var enemy : TacticsEnemyController
var arena : TacticsArena
var camera : TacticsCamera
var ui_control : TacticsPlayerControllerUI

var stage : int = 0


func _ready():
	player = $Player
	enemy = $Enemy
	arena = $Arena
	camera = $TacticsCamera
	ui_control = $PlayerControllerUI
	arena.configure()
	player.configure(arena, camera, ui_control)
	enemy.configure(arena, camera, ui_control)


func post_configure():
	if player.post_configure() and enemy.post_configure():
		stage = 1


func turn_handler(delta):
	if player.can_act() : player.act(delta)
	elif enemy.can_act() : enemy.act(delta)
	else:
		player.reset()
		enemy.reset()


func _physics_process(delta):
	match stage:
		0: post_configure()
		1: turn_handler(delta)

