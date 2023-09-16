extends MultiplayerSpawner
#var textture = preload("res://assets/champions/robbin/A1.png")
@export var projectile : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_function = func(data):
		var model = load("res://src/champions/"+data.champion+"/Abilities/"+data.ability+"/"+data.ability+"Model.tscn")
		var pro = projectile.instantiate()
		pro.model = model.instantiate()
		return pro
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_despawned(node):
	pass
