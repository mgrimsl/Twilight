extends Node3D

var eDelta = 0
var isAuth = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _physics_process(delta):
	eDelta = delta
	if is_multiplayer_authority():
		if Input.is_action_just_pressed("Attack"):
			pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _enter_tree():
	print("Player: ", name, " Entered the Tree")

func _on_timer_timeout():
	pass
	
func _on_player_attacked():
	rpc("_attacked", str(name))

@rpc("any_peer") func updateState(id,State):
	if(id == name):
		$Player.updateMovementState(State["MovementState"])
		$Player.updateAttkStat(State["AttackState"])
		
@rpc("any_peer") func attack(targetId, MovementState):
	var parent = get_parent()
	var target = parent.get_node(str(targetId))
	$Player.target = target.get_node("Player")
	$Player.updateMovementState(MovementState)
	$Player.attack()
	#print($Player.name, " attacked ", $Player.target.name, " at target pos ", $Player.target.get)

@rpc("reliable", "any_peer") func sendChampData(champData):
	$Player.champData = champData
	$Player.setBaseStats(champData)

@rpc("any_peer") func _updateDest(id,pos):
	pass
@rpc("any_peer") func _attacked(target):
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

