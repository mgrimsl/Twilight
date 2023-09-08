extends StaticBody3D
signal move(destination:Vector3)
signal ability1(destination:Vector3)
var mouse = Vector3()
var navBallScn = preload("res://src/ui/nav_ball.tscn")
var navBall
# Called when the node enters the scene tree for the first time.
func _ready():
	navBall = navBallScn.instantiate()
	add_child(navBall)
	navBall.position = mouse

func _input(event):
	#print(event)
	if event.is_action_pressed("Ability1"):
		pass
		#emit_signal("ability1", mouse)

func _input_event(_camera, event, mPosition, _normal, _shape_idx):
	#mPosition.y = 1
	mouse = mPosition
	mouse.y =1
	if event.is_action_pressed("Right-Click"):
		emit_signal("move", mouse)
		print(mPosition)
		navBall.position = mPosition



