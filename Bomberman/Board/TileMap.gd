extends TileMap

var _sparks = load("res://Board/explosionParticle.scn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func bumv(initialPos, player, radius):
	var sparks
	var leng
	var pos
	var step
	sparks = _sparks.instance()
	sparks.position = map_to_world(world_to_map(initialPos)) + Vector2(32, 32)
	add_child(sparks) 
	sparks.set_one_shot(true)
	sparks.set_emitting(true)
	
	
	for i in range(4):
		leng = radius	
		pos = initialPos
		if (i == 0):
			step = Vector2(-64, 0)
		if (i == 1):
			step = Vector2(0, 64)
		if (i == 2):
			step = Vector2(64, 0)
		if (i == 3):
			step = Vector2(0, -64)
		pos += step
		while get_cellv(world_to_map(pos)) != 0 and leng !=0   :
			sparks = _sparks.instance()
			sparks.position = map_to_world(world_to_map(pos)) + Vector2(32, 32)
			add_child(sparks) 
			sparks.set_one_shot(true)
			sparks.set_emitting(true)
			leng -= 1
			pos += step
		

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