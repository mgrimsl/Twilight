extends Node

var target = null
# Called when the node enters the scene tree for the first time.
func _ready():
	print(multiplayer.get_unique_id())


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _input(event):
	var aMouse = $"../Map/Ground".aMouse
	var gMouse = $"../Map/Ground".gMouse
	var input = ""
	var keyReleased = false
	if Input.is_action_just_pressed("A1"):
		input = "A1"
	if Input.is_action_just_pressed("A2"):
		input = "A2"
	if Input.is_action_just_pressed("A3"):
		input = "A3"
	if Input.is_action_just_pressed("A4"):
		input = "A4"
	if Input.is_action_just_pressed("Right-Click"):
		input = "Right-Click"
	if Input.is_action_just_pressed("Click"):
		pass
	if Input.is_action_just_released("A1"):
		keyReleased = true
		input = "A1"
	if Input.is_action_just_released("A2"):
		keyReleased = true
		input = "A2"
	if Input.is_action_just_released("A3"):
		keyReleased = true
		input = "A3"
	if Input.is_action_just_released("A4"):
		keyReleased = true
		input = "A4"
	if !multiplayer.is_server():
		rpc_id(1,"input", input, aMouse, gMouse, keyReleased, target)


@rpc() func input(input, aMouse, gMouse, keyReleased, target = null):
	pass
