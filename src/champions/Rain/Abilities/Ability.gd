
extends Area3D

var damage = 20 

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

@rpc() func sync(pos, targetPos, remove = false):
	if remove:
		queue_free()
		return
	position = lerp(position,pos, 1)
	

