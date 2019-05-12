extends TileMap

var _sparks = load("res://Board/explosionParticle.tscn")
var _bomb = load("res://Board/bomb.tscn")
var _light = load("res://Board/Light2D.tscn")
var _collapse1 = load("res://Board/Collapses/Collapse1.tscn")
var _collapse2 = load("res://Board/Collapses/Collapse2.tscn")
var _collapse3 = load("res://Board/Collapses/Collapse3.tscn")

var bomb
var light
var dangerList
var resizeCount

signal explosion( dangerList, Player)


func spawnPowerUP(pos):
	randomize()
	if (randi() % 100) < 50: #50% szans ze wypadnie powerup
		var type = randi() % 3
		if type == 0:
			var powerup = preload("res://Player//MoreBombs.tscn").instance()
			powerup.position = pos
			get_parent().add_child(powerup)
		elif type == 1:
			var powerup = preload("res://Player//BetterBombs.tscn").instance()
			powerup.position = pos
			get_parent().add_child(powerup)
		elif type == 2:
			var powerup = preload("res://Player//SpeedUP.tscn").instance()
			powerup.position = pos
			get_parent().add_child(powerup)

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
				leng = 1
				spawnPowerUP(pos)
			sparks = _sparks.instance()
			sparks.position = map_to_world(world_to_map(pos)) + Vector2(32, 32)
			dangerList.append(world_to_map(pos))
			add_child(sparks) 
			sparks.set_one_shot(true)
			sparks.set_emitting(true)
			leng -= 1
			pos += step
	
	emit_signal("explosion", dangerList, player)

func place_bomb(initialPos, player,  radius):
	var properPos = map_to_world(world_to_map(initialPos)) + Vector2(32, 32)
	bomb = _bomb.instance()
	bomb.radius = radius
	bomb.position = properPos
	add_child(bomb)

func resize():
	var collapse
	if(resizeCount == 1):
		collapse = _collapse1.instance()
	elif(resizeCount == 2):
		collapse = _collapse2.instance()
	else:
		collapse = _collapse3.instance()
	add_child(collapse)
	resizeCount += 1

func _ready():
	resizeCount = 1


func _process(delta):
	if(Input.is_action_just_pressed("ui_select")):
		resize()