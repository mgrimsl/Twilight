
extends Node3D

var damage = 20 
#var pro = preload("res://src/champions/Robbin/Abilities/Projectiles/projectile.tscn")
var dest = Vector3()
var velocity = Vector3.ZERO
var start = Vector3()
var constantTravel = true
var travelDistance = 7
var speed = .3
var own
var active = true
var target
signal hit(target: CharacterBody3D)
var i = 0

func spawnDebug(title, nodeName):
	var meshInstance = MeshInstance3D.new()
	setMeshSize(1, 1, meshInstance)
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
	meshInstance.set_surface_override_material(0,mat)
	meshInstance.name = nodeName
	add_child(meshInstance, true)

func setMeshSize(length, width, meshInstance):
	if length > 0 && width > 0:

		var planeMesh = PlaneMesh.new()
		planeMesh.size = Vector2(width,length)
		meshInstance.mesh = planeMesh
	elif width > 0:

		var sphereMesh = SphereMesh.new()
		sphereMesh.radius = width
		sphereMesh.height = 0.01
		meshInstance.mesh = sphereMesh
