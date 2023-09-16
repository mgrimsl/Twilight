extends Node3D
var players = [] 
var authJoined = false
var lbFillRed = preload("res://assets/GUI/lifebar_fill_Red.png")
var lbBGRed = preload("res://assets/GUI/lifebar_bg_Red.png")
var normalCur = preload("res://assets/GUI/Cursors/normal.png")
var atkCur = preload("res://assets/GUI/Cursors/atk.png")
@onready var IH = get_parent().get_node("InputHandler")

func playerAdded(player):
	player.MouseEntered.connect(mouseEnter)
	player.MouseExited.connect(mouseExit)
	if str(multiplayer.get_unique_id()) != player.name:
		players.append(player.name)
		var floatGUI = player.get_node("FloatGUI/HBoxContainer/Bars/Bar/Count/BackGround/Gauge")
		floatGUI.texture_progress = lbFillRed
		floatGUI.texture_under = lbBGRed


func mouseEnter(name):
	print(name)
	IH.target = str(name)
	Input.set_custom_mouse_cursor(atkCur)
	get_parent().get_node("InputHandler").target = name
func mouseExit(name):
	print("exit")
	IH.target = null
	Input.set_custom_mouse_cursor(normalCur)
	get_parent().get_node("InputHandler").target = null

	
