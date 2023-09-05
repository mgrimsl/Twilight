extends Node
@onready var world = get_tree().root.get_child(1)
@onready var hotBar = world.get_node("GUI/HotBar")
@onready var mainGuage = world.get_node("GUI/HBoxContainer/Bars/Bar/Count/BackGround/Gauge")
func _ready():
	pass
