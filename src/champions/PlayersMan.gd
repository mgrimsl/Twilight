extends Node3D
var players = []
var authMod
var authRPC 
var authJoined = false
var lbFillRed = preload("res://assets/GUI/lifebar_fill_Red.png")
var lbBGRed = preload("res://assets/GUI/lifebar_bg_Red.png")
var normalCur = preload("res://assets/GUI/Cursors/normal.png")
var atkCur = preload("res://assets/GUI/Cursors/atk.png")
@onready var IH = get_parent().get_node("InputHandler")

func playerAdded(player):
	var playerMod = player.get_node("Player")
	playerMod.mouse_entered.connect(mouseEnter.bind(player.name))
	playerMod.mouse_exited.connect(mouseExit.bind(player.name))
	if str(multiplayer.get_unique_id()) != player.name:
		players.append(player.name)
		var floatGUI = player.get_node("Player/FloatGUI/HBoxContainer/Bars/Bar/Count/BackGround/Gauge")
		floatGUI.texture_progress = lbFillRed
		floatGUI.texture_under = lbBGRed
	else:
		authRPC = player
		authMod = playerMod
		player.isAuth = true
		authJoined = true

func mouseEnter(name):
	IH.target = str(name)
	Input.set_custom_mouse_cursor(atkCur)
func mouseExit(name):
	IH.target = null
	Input.set_custom_mouse_cursor(normalCur)

	
