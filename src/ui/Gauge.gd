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
	max_value = maxHealth
	value = currentHealth

	$"../Number".text = "%0.0f" %currentHealth
	#if value <= 0:
	#	currentHealth = maxHealth
	#	$"../Number".text = "%0.0f" %currentHealth

func setHP(max, current):
	maxHealth = max
	currentHealth = current
