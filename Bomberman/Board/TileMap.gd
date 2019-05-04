extends TileMap

var _sparks = load("res://Board/explosionParticle.scn")
var _bomb = load("res://Board/bomb.tscn")
var _light = load("res://Board/Light2D.tscn")

var bomb
var light
var dangerList


signal explosion( dangerList)


func bumv(initialPos, player, radius):
	var sparks
	var leng
	var pos
	var step
	dangerList = Array()
	
	light = _light.instance()
	light.position = map_to_world(world_to_map(initialPos)) + Vector2(32, 32)
	add_child(light)
	
	sparks = _sparks.instance()
	sparks.position = map_to_world(world_to_map(initialPos)) + Vector2(32, 32)
	dangerList.append(world_to_map(initialPos))
	add_child(sparks) 
	sparks.set_one_shot(true)
	sparks.set_emitting(true)
	
	
	for i in range(4):
		leng = radius	
		pos = initialPos
		if (i == 0):
			step = Vector2(-64, 0)
		elif (i == 1):
			step = Vector2(0, 64)
		elif (i == 2):
			step = Vector2(64, 0)
		elif (i == 3):
			step = Vector2(0, -64)
		pos += step
		while get_cellv(world_to_map(pos)) != 0 and leng !=0   :
			if(get_cellv(world_to_map(pos)) == 2):
				set_cellv(world_to_map(pos), 1)
			sparks = _sparks.instance()
			sparks.position = map_to_world(world_to_map(pos)) + Vector2(32, 32)
			dangerList.append(world_to_map(pos))
			add_child(sparks) 
			sparks.set_one_shot(true)
			sparks.set_emitting(true)
			leng -= 1
			pos += step
	
	emit_signal("explosion", dangerList)

func place_bomb(initialPos, player,  bombType):
		bomb = _bomb.instance()
		bomb.position = map_to_world(world_to_map(initialPos)) + Vector2(32, 32)
		add_child(bomb)
		
		
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