extends Node
var Ability = preload("res://src/champions/Rain/Abilities/Ability.tscn")
var arrow = preload("res://assets/champions/robbin/arrow.glb")
var ability
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


@rpc() func cooldown(title, timeleft, timeout = false):
	if timeout:
		print("yes")
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
		#get_parent().get_node("GUI/HotBar").get_node(title).text = txt
		get_node("/root/Global").hotBar.get_node(title).text = txt
		return
	get_node("/root/Global").hotBar.get_node(title).text = str(timeleft)


@rpc() func spawnAbility(title, nodeName, target):
	ability = Ability.instantiate()
	ability.name = nodeName
	#ability.visible = false
	ability.position = get_parent().get_node("Player").position
	add_child(ability, true)
	ability = get_node(str(ability.name))

func createMesh(length , width, title):
	var meshInstance = ability.get_node("MeshInstance3D")
	setMeshSize(length, width)
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
	#meshInstance.set_surface_override_material(0,mat)
	#meshInstance.mesh = arrow
	
func setMeshSize(length, width):
	if length > 0 && width > 0:
		var meshInstance = ability.get_node("MeshInstance3D")
		var planeMesh = PlaneMesh.new()
		planeMesh.size = Vector2(width,length)
		meshInstance.mesh = planeMesh
	elif width > 0:
		var meshInstance = ability.get_node("MeshInstance3D")
		var sphereMesh = SphereMesh.new()
		sphereMesh.radius = width
		sphereMesh.height = 0.01
		meshInstance.mesh = sphereMesh

	
