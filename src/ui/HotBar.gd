extends BoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _input(event):
	if Input.is_action_just_pressed("Ability1"):
		$A1.set_pressed_no_signal(true)
	if Input.is_action_just_pressed("Ability2"):
		$A2.set_pressed_no_signal(true)
	if Input.is_action_just_pressed("Ability3"):
		$A3.set_pressed_no_signal(true)
	if Input.is_action_just_pressed("Ability4"):
		$A4.set_pressed_no_signal(true)
