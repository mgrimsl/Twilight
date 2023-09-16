class_name Ability extends Node3D

@export var cd : bool = false
@export var CDTimeLeft : float = 0

func _ready():
	print("HERE")
func _process(delta):
	pass
	#get_node("/root/Global").hotBar.get_node(name).text = str(int(CDTimeLeft))
