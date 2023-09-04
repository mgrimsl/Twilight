extends Node

var target = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var mouse = $"../Map/Ground".mouse
	var input = ""
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
	if input == "":
		return
	
	rpc_id(1,"input", input, mouse, target)


@rpc() func input(input, mouse, target = null):
	pass
