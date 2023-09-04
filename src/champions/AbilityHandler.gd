extends Node
var Ability = preload("res://src/champions/Rain/Abilities/Ability.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

@rpc() func spawnAbility(name):
	var ability
	ability = Ability.instantiate()
	ability.name = name
	add_child(ability)
	ability = get_node(str(name))
	var mesh :MeshInstance3D
	mesh = ability.get_node("MeshInstance3D")
	var mat = StandardMaterial3D.new()
	
	match name:
		"AA":
			mat.albedo_color = Color(100,0,0)
		"P":
			pass
		"A1":
			mat.albedo_color = Color(0,0,100)
		"A2":
			mat.albedo_color = Color(0,100,0)
		"A3":
			mat.albedo_color = Color(50,0,50)
		"A4":
			mat.albedo_color = Color(50,50,0)
	mesh.set_surface_override_material(0,mat)
	
