extends Node3D

@export var model : Sprite3D
# Called when the node enters the scene tree for the first time.
func _ready():
	print("added model")
	add_child(model)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
