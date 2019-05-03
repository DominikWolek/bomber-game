extends TileMap

var matrix=[]


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var _sparks = load("res://Board/explosionParticle.scn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(15):
		matrix.append([])
		matrix[x]=[]        
		for y in range(11):
			matrix[x].append([])
			matrix[x][y] = false
	pass # Replace with function body.

func bumv(_position, player):
		var sparks = _sparks.instance()
		sparks.position = _position
		add_child(sparks) # They have a very high Z position, so being buried would not be a problem
		sparks.set_one_shot(true)
		sparks.set_emitting(true)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	

# Somewhere in the input handler then:
	#if(Input.is_action_just_pressed("ui_right")):
		#bumv(Vector2(500, 500), "dupa")
	pass
