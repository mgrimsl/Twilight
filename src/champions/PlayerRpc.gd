extends Node3D

var eDelta = 0
var isAuth = false
var target = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _enter_tree():
	get_parent().playerAdded(self)

func _on_timer_timeout():
	pass

@rpc() func updateState(State):
	$Player.target = State["target"]
	$Player.updateMovementState(State["MovementState"])
	$Player.updateAttkStat(State["AttackState"])
	$Player.setBaseStats(State["BaseStats"])

@rpc() func _updateDest(id,pos):
	pass
			
func V2to3(vector2 : Vector2):
	var vector3 = Vector3.ZERO
	vector3.x = vector2.x 
	vector3.z = vector2.y
	vector3.y=1
	return vector3

func V3to2(vector3 : Vector3):
	var vector2 = Vector2.ZERO
	vector2.x = vector3.x 
	vector2.y = vector3.z
	return vector2

