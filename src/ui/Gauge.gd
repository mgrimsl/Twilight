extends TextureProgressBar

var maxHealth = 1
var currentHealth = 1
var Player = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	max_value = currentHealth
	value = maxHealth
	currentHealth = maxHealth
	$"../Number".text = "%0.0f" %currentHealth

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(Player == null):
		return
	
	maxHealth = Player.maxHealth
	currentHealth = Player.currentHealth
	value = currentHealth
	max_value = maxHealth

	$"../Number".text = "%0.0f" %currentHealth


func setHP(max, current):
	maxHealth = max
	currentHealth = current
