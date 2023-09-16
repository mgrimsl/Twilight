class_name Champion extends Node3D

@export var maxHealth = 200
@export var currentHealth = 200

@export var destination = Vector3(0,0,0)
@export var moving = false
@export var channel = false
@export var stunned = false
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
var animator : AnimationPlayer
var floatGUI
var GUI

signal RightClicked(enemy:CharacterBody3D)
signal MouseEntered(enemyName)
signal MouseExited(enemyName)

func _enter_tree():
	get_parent().playerAdded(self)

func _on_timer_timeout():
	pass


func _ready():
	var timer = Timer.new()
	timer.wait_time = 5
	animator = $StylizedCharacter/AnimationPlayer

	floatGUI = $FloatGUI/HBoxContainer/Bars/Bar/Count/BackGround/Gauge
	floatGUI.Player = self
	$FloatGUI/HBoxContainer/Bars/Bar/Count/BackGround/DebugName.text = name  #str(position.x) + "," + str(position.y) + "," + str(position.z)
	GUI = get_tree().root.get_child(1).get_node("GUI/HBoxContainer/Bars/Bar/Count/BackGround/Gauge")
	if str(multiplayer.get_unique_id()) == name:
		print("set to", name)
		GUI.Player = self
func _physics_process(delta):
	animationHandel()
	HandleGUI_Move()

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
	var vpPos = $"../../Camera3D".unproject_position(position)
	vpPos.x -= 85
	vpPos.y -= 100
	$FloatGUI.position = vpPos
	#$Float#GUI/HBoxContainer/Bars/Bar/Count/BackGround/DebugName.text =  str(position.x) + "," + str(position.y) + "," + str(position.z)

func stop():
	moving = false

func hit(damage, player, name):
	$FloatGUI/HBoxContainer/Bars/Bar/Count/BackGround/Gauge.on_hit(damage)
	if is_multiplayer_authority():
		pass
		#$"../../../GUI/HBoxContainer/Bars/Bar/Count/BackGround/Gauge".on_hit(damage)


func _on_input_event(camera, event, position, normal, shape_idx):
	position.y = 1
	#get_parent().get_parent().get_parent().get_node("Map").get_node("Ground").mouse = position
	if Input.is_action_just_pressed("Right-Click"):
		emit_signal("RightClicked",get_parent().name)

func _on_mouse_exited():
	emit_signal("MouseExited",name)

func _on_mouse_entered():
	emit_signal("MouseEntered",name)

