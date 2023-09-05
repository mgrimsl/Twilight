extends Node3D

var isServer = false
var local = true
var remoteServerIP = "20.115.123.255"
var port = 8080
@export var player_scene : PackedScene
@onready var cam = $Camera3D
var champSelectButton = preload("res://src/ui/ChampSelectButton.tscn")
#signal player_connected(peer_id, player_info)
#signal player_disconnected(peer_id)
var quit
var join
var champId
var playerNum = -1
# This will contain player info for every player, with the keys being each player's unique IDs.
var players = {}
var champs = []

# This is the local player info. This should be modified locally before the connection is made.
# It will be passed to every other peer.
# For example, the value of "name" can be set to something the player entered in a UI scene.
var player_info = {"name": "Name"}

var players_loaded = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.request_completed.connect(_populate_champ_buttons)
	$HTTPRequest.request("http://" +remoteServerIP+":8081/api/collections/champions/records/?fields=name,id")
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.peer_connected.connect(_on_peer_connected)
	quit = $GUI/HBoxContainer/Bars/Quit
	quit.pressed.connect(_on_quit_pressed)
	join = $GUI/HBoxContainer/Bars/Join
	join.pressed.connect(_on_join_pressed)
	if(isServer):
		var peer = ENetMultiplayerPeer.new()
		peer.create_server(8080)
		multiplayer.multiplayer_peer = peer
		CheckButton
	$GUI/HBoxContainer/Bars/CheckButton.toggled.connect(_on_local_togggled)

@rpc("reliable") func _selectChampion(id):
	pass
@rpc("reliable")
func _register_player(id):
	var player = player_scene.instantiate()
	player.name = str(id)
	$PlayersMan.add_child(player)
	$GUI/HBoxContainer/Bars/Bar/Count/BackGround/Gauge.Player = player

@rpc("reliable") func _del_player(id):
	print("remote sender: ", multiplayer.get_remote_sender_id(), " wants to delte id: ", id)
	$PlayersMan.get_node(str(id)).queue_free()
	
func _on_join_pressed():
	var peer = ENetMultiplayerPeer.new()
	if local:
		peer.create_client("localhost",port)
	else:
		peer.create_client(remoteServerIP,port)
	multiplayer.multiplayer_peer = peer

func _on_quit_pressed():
	$PlayersMan.authJoined = false
	var id = multiplayer.get_unique_id()
	multiplayer.multiplayer_peer=null
	$PlayersMan.get_node(str(id)).queue_free()
	$GUI/HBoxContainer/Bars/Join.visible = true
	$GUI/HBoxContainer/Bars/Quit.visible = false

func _on_peer_connected(id):
	print("peer connected id: ", id, " my name is : ", get_multiplayer_authority())
	if(id != 1):
		_register_player(id)
	
func _on_connected_to_server():
	rpc("_selectChampion", champId)
	$GUI/HBoxContainer/Bars/Join.visible = false
	$GUI/HBoxContainer/Bars/Quit.visible = true
	print("Connected to Server")

func _on_champ_select(id):
	$GUI/HBoxContainer/Bars/Join.visible = true
	champId = id
	for champ in champs:
		$GUI/HBoxContainer/Bars.get_node(str(champ)).visible = false
	#rpc_id(1, "_selectChampion", id)

func _on_local_togggled(value):
	print(value)
	if !value:
		local = true;
	else:
		local = false

func _populate_champ_buttons(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	for name in json["items"]:
		var button = champSelectButton.instantiate()
		button.text = name["name"]
		button.name = name["id"]
		button._champSelect.connect(_on_champ_select)
		champs.append(name["id"])
		$GUI/HBoxContainer/Bars.add_child(button)
