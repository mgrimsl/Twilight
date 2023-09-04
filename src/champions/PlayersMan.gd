extends Node3D
var players = []
var authMod
var authRPC 
var authJoined = false
var lbFillRed = preload("res://assets/GUI/lifebar_fill_Red.png")
var lbBGRed = preload("res://assets/GUI/lifebar_bg_Red.png")
@onready var IH = get_parent().get_node("InputHandler")
func playerAdded(player):
	#print("new player added: ", player.name, " is auth?: ", isAuth)
	
	var playerMod = player.get_node("Player")
	#playerMod.RightClicked.connect(on_player_right_clicked)
	playerMod.mouse_entered.connect(mouseEnter.bind(player.name))
	playerMod.mouse_exited.connect(mouseExit.bind(player.name))
	if authJoined:
		players.append(player.name)
		var floatGUI = player.get_node("Player/FloatGUI/HBoxContainer/Bars/Bar/Count/BackGround/Gauge")
		floatGUI.texture_progress = lbFillRed
		floatGUI.texture_under = lbBGRed
	else:
		authRPC = player
		authMod = playerMod
		player.isAuth = true
		authJoined = true
#	playerMod.attacked.connect(_on_player_attacked)

func mouseEnter(name):
	IH.target = str(name)
func mouseExit(name):
	IH.target = null

	
