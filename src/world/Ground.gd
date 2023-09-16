extends StaticBody3D
signal move(destination:Vector3)
signal ability1(destination:Vector3)
var gMouse = Vector3()
var aMouse = Vector3()
var navBallScn = preload("res://src/ui/nav_ball.tscn")
var navBall
var cam
# Called when the node enters the scene tree for the first time.
func _ready():
	navBall = navBallScn.instantiate()
	add_child(navBall)
	navBall.position = gMouse
	cam = get_parent().get_parent().get_node("Camera3D")


func _on_input_event(camera, event, mPosition, normal, shape_idx):
	gMouse = mPosition
	aMouse = gMouse + gMouse.direction_to(cam.position)
	if event.is_action_pressed("Right-Click"):
		emit_signal("move", gMouse)
		navBall.position = mPosition
		navBall.position.y = 0
