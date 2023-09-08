extends CharacterBody3D


#stats

var champData = {}
#Ability 1
var Ab1Channel = .4
var A1Cd = 1
var canCastA1 = true
var A1Timer : Timer
var ChannelTimer : Timer
#Auto Attacks
var attacking = false
var inWindUp = false
var target
#movment
var moving = false
var destination = Vector3(1,1,1)
var movment = Vector3()

var channel = false
var mouse = Vector3()
var skillDest = Vector3()
var animator : AnimationPlayer
var floatGUI 
var GUI

signal RightClicked(enemy:CharacterBody3D)
signal MouseEntered(enemyName)
signal MouseExited(enemyName)
#@onready var cam = $"../Camera3D"
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	animator = $StylizedCharacter/AnimationPlayer
	var ground = $"../../../Map/Ground"
	ground.move.connect(_on_ground_move)
	floatGUI = $FloatGUI/HBoxContainer/Bars/Bar/Count/BackGround/Gauge
	floatGUI.Player = self
	$FloatGUI/HBoxContainer/Bars/Bar/Count/BackGround/DebugName.text = get_parent().name
	GUI = get_tree().root.get_child(1).get_node("GUI/HBoxContainer/Bars/Bar/Count/BackGround/Gauge")
func _physics_process(delta):
	if(target != null):
		look_at(target, Vector3.UP)
	else:
		look_at(destination, Vector3.UP)
	animationHandel()
	HandleGUI_Move()
#
func updateMovementState(MovementState):
		destination = MovementState["destination"]
		position = lerp(position, MovementState["position"], 1)
		moving = MovementState["moving"]

func animationHandel():
	if channel:
		animator.play("Punch_R")
	elif moving:
		animator.play("Run")
	elif channel:
		animator.play("Punch_R")
	else:
		animator.play("Iddle")

func HandleGUI_Move():
	var vpPos = $"../../../Camera3D".unproject_position(position)
	vpPos.x -= 145
	vpPos.y -= 125
	$FloatGUI.position = vpPos

func stop():
	moving = false

func updateAttkStat(AttackState):
	channel = AttackState["channel"]
	attacking = AttackState["attacking"]

func _on_ground_move(dest):
	var rpc = get_parent()
	target = null
	rpc.rpc_id(1, "_updateDest", get_parent().name, dest)

func hit(damage, player, name):
	$FloatGUI/HBoxContainer/Bars/Bar/Count/BackGround/Gauge.on_hit(damage)
	if is_multiplayer_authority():
		pass
		$"../../../GUI/HBoxContainer/Bars/Bar/Count/BackGround/Gauge".on_hit(damage)

func _on_input_event(camera, event, position, normal, shape_idx):
	position.y = 1
	get_parent().get_parent().get_parent().get_node("Map").get_node("Ground").mouse = position
	if Input.is_action_just_pressed("Right-Click"):
		emit_signal("RightClicked",get_parent().name)

func setBaseStats(baseStats):
	if get_parent().name == str(multiplayer.get_unique_id()):
		get_node("/root/Global").mainGuage.setHP(baseStats["maxHealth"],baseStats["currentHealth"])
	floatGUI.setHP(baseStats["maxHealth"],baseStats["currentHealth"])

	

func _on_mouse_exited():
	emit_signal("MouseEntered",get_parent().name)

func _on_mouse_entered():
	emit_signal("MouseExited",get_parent().name)
