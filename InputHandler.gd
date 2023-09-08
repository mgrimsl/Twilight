extends Node

var target = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var mouse = $"../Map/Ground".mouse
	var input = ""
	var keyReleased = false
	if Input.is_action_just_pressed("Ability1"):
		input = "Ability1"
	if Input.is_action_just_pressed("Ability2"):
		input = "Ability2"
	if Input.is_action_just_pressed("Ability3"):
		input = "Ability3"
	if Input.is_action_just_pressed("Ability4"):
		input = "Ability4"
	if Input.is_action_just_pressed("Right-Click"):
		input = "Right-Click"
	if Input.is_action_just_pressed("Click"):
		pass
	if Input.is_action_just_released("Ability1"):
		keyReleased = true
		input = "Ability1"
	if Input.is_action_just_released("Ability2"):
		keyReleased = true
		input = "Ability2"
	if Input.is_action_just_released("Ability3"):
		keyReleased = true
		input = "Ability3"
	if Input.is_action_just_released("Ability4"):
		keyReleased = true
		input = "Ability4"
	if !multiplayer.is_server():
		rpc_id(1,"input", input, mouse, keyReleased, target)


@rpc() func input(input, mouse,keyReleased, target = null):
	pass
