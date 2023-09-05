extends Node
var Ability = preload("res://src/champions/Rain/Abilities/Ability.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


@rpc() func cooldown(title, timeleft, timeout = false):
	if timeout:
		var txt = ""
		match title:
			"AA":
				return
			"P":
				return
			"A1":
				txt = "Q"
			"A2":
				txt = "W"
			"A3":
				txt = "E"
			"A4":
				txt = "R"
		get_node("/root/Global").hotBar.get_node(title).text = txt
		return
	get_node("/root/Global").hotBar.get_node(title).text = str(timeleft)


@rpc() func spawnAbility(title, nodeName, size):
	var ability
	ability = Ability.instantiate()
	ability.name = nodeName
	ability.scale = Vector3(size,size,size)
	add_child(ability, true)
	ability = get_node(str(ability.name))
	print(title)
	var mesh :MeshInstance3D
	mesh = ability.get_node("MeshInstance3D")
	var mat = StandardMaterial3D.new()
	
	match title:
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
	
