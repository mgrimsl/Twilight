extends CharacterBody3D


#stats

var champData = {}
#Ability 1
var Ab1Channel = .4
var A1Cd = 1
var canCastA1 = true
var A1Timer : Timer
var ChannelTimer : Timer
var ability1scn = preload("res://src/champions/Rain/Abilities/ability_1.tscn")
#Auto Attacks
var attacking = false
var inWindUp = false
var target
var autoAttackscn = preload("res://src/champions/Rain/AutoAttack/auto_attack.tscn")
#movment
var moving = false
var destination = Vector3(1,1,1)
var movment = Vector3()

var channel = false
var mouse = Vector3()
var skillDest = Vector3()
var animator : AnimationPlayer
var floatGUI 

signal attacked(enemy:CharacterBody3D)
@onready var cam = $"../Camera3D"
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	animator = $StylizedCharacter/AnimationPlayer
	var ground = $"../../../Ground"
	ground.move.connect(_on_ground_move)
	ground.ability1.connect(_on_ground_ability_1)
	floatGUI = $FloatGUI/HBoxContainer/Bars/Bar/Count/BackGround/Gauge
	$FloatGUI/HBoxContainer/Bars/Bar/Count/BackGround/DebugName.text = get_parent().name
	

func _physics_process(delta):
	if channel:
		return
	look_at(destination, Vector3.UP)
	animationHandel()
	HandleGUI_Move()
#
func updateMovementState(MovementState):
		destination = MovementState["destination"]
		position = lerp(position, MovementState["position"], 1)
		moving = MovementState["moving"]

func animationHandel():
	if moving:
		animator.play("Run")
	elif inWindUp:
		animator.play("Punch_R")
	else:
		animator.play("Iddle")

func HandleGUI_Move():
	var vpPos = $"../../../Camera3D".unproject_position(position)
	vpPos.x -= 160
	vpPos.y -= 220
	$FloatGUI.position = vpPos

func stop():
	moving = false

func updateAttkStat(AttackState):
	inWindUp = AttackState["inWindUp"]
	attacking = AttackState["attacking"]

func attack():
	var autoAttack = autoAttackscn.instantiate()
	autoAttack.init(position, target)
	add_sibling(autoAttack)

func _on_ground_move(dest):
	get_parent().rpc_id(1, "_updateDest", get_parent().name, dest)

func _on_ground_ability_1(dest = mouse):
	destination = dest
	if !canCastA1:
		return
	look_at(dest, Vector3.UP)
	stop()
	A1Timer.wait_time = A1Cd
	A1Timer.start()
	ChannelTimer.wait_time = Ab1Channel
	ChannelTimer.start()
	canCastA1 = false
	channel = true
	skillDest = dest
	animator.play("Kick_R")

func _on_a_1cd_timeout():
	A1Timer.stop()
	canCastA1 = true

func _on_channel_timeout():
	ChannelTimer.stop()
	channel = false
	var ability1 = ability1scn.instantiate()
	ability1.init(skillDest, position, self)
	call_deferred("add_sibling", ability1)

func hit(damage, player, name):
	print(player, " ", name)
	$FloatGUI/HBoxContainer/Bars/Bar/Count/BackGround/Gauge.on_hit(damage)
	if is_multiplayer_authority():
		pass
		$"../../GUI/HBoxContainer/Bars/Bar/Count/BackGround/Gauge".on_hit(damage)

func _on_input_event(camera, event, position, normal, shape_idx):
	if Input.is_action_just_pressed("Attack"):
		emit_signal("attacked")

func setBaseStats(champData):
	self.champData = champData
	floatGUI.MaxHealth = champData["baseStats"]["maxHealth"]
