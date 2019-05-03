extends TileMap

var _sparks = load("res://Board/explosionParticle.scn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func bumv(_position, player):
		var sparks = _sparks.instance()
		sparks.position = _position
		add_child(sparks) # They have a very high Z position, so being buried would not be a problem
		sparks.set_one_shot(true)
		sparks.set_emitting(true)
	


func create_2d_array(width, height, value):
    var a = []

    for y in range(height):
        a.append([])
        a[y].resize(width)

        for x in range(width):
            a[y][x] = value

    return a

var bombs = create_2d_array(15, 11, false)

	
func _process(delta):
	
	pass
