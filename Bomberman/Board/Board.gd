extends TileMap

var _sparks = load("res://Board/explosionParticle.tscn")
var _bomb = load("res://Board/bomb.tscn")
var _light = load("res://Board/Light2D.tscn")


var hitmark
var bomb
var light
var dangerList

var bombsCount

var resizeCount
var resizeTime

var damageList: Dictionary

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

func bumv(initialPos, player):
	var sparks
	var leng
	var pos
	var step
	dangerList = Array()
	
	light = _light.instance()
	light.position = map_to_world(world_to_map(initialPos)) + Vector2(32, 32)
	add_child(light)
	Sounds.get_node("Explosion").position = initialPos
	Sounds.get_node("Explosion").play()
	
	sparks = _sparks.instance()
	sparks.position = map_to_world(world_to_map(initialPos)) + Vector2(32, 32)
	dangerList.append(world_to_map(initialPos))
	add_child(sparks) 
	sparks.set_one_shot(true)
	sparks.set_emitting(true)
	
	
	
	for i in range(4):
		leng = damageList[player]
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

func place_bomb(initialPos, player):
	bomb = _bomb.instance()
	bomb.placedBy = player
	bomb.position = map_to_world(world_to_map(initialPos)) + Vector2(32, 32)
	add_child(bomb)
		
		
func resize():
	if(resizeCount <=5):
		var _collapse = load("res://Board/Collapses/Collapse"+str(resizeCount)+".tscn")
		var collapse = _collapse.instance()
		add_child(collapse)
		resizeCount += 1
		


func shuffleList(list):
	var shuffledList = []
	randomize()
	var indexList = range(list.size())
	for i in range(list.size()):
		var x = randi()%indexList.size()
		shuffledList.append(list[indexList[x]])
		indexList.remove(x)
	return shuffledList
	
	
func _ready():
	Sounds.get_node("MainMenu").stop()
	Sounds.get_node("The Pirate And The Dancer").play()
	
	var _gameInfo = get_node("/root/ConfigurationNode").gameInfo
	
	if(_gameInfo.map == 0):
		set_tileset(load("res://Assets/TileSets/dirt.tres"))
	elif(_gameInfo.map == 1):
		set_tileset(load("res://Assets/TileSets/wood.tres"))
	elif(_gameInfo.map == 2):
		set_tileset(load("res://Assets/TileSets/Water.tres"))
		
	
	var _pos1 = Vector2( 64+32, 64+32 ) 
	var _pos2 = Vector2( 64*13+32, 64 )
	var _pos3 = Vector2( 64+32 , 10*64 - 32 )
	var _pos4 = Vector2( 64*13 +32 ,10*64-32 )
	
	
	
	var _positions = [_pos1,_pos2,_pos3,_pos4]
	_positions = shuffleList(_positions)
	
	var _p1
	var _p2
	var _p3
	var _p4
	
	
	_p1 = load("res://Player/Player.tscn").instance()
	
	if _gameInfo.P2.isPlaying :
		if _gameInfo.P2.isBot :
			_p2 = load("res://Bot/Bot.tscn").instance()
		else:
			_p2 = load("res://Player/Player.tscn").instance()
	
	if _gameInfo.P3.isPlaying :
		if _gameInfo.P3.isBot :
			_p3 = load("res://Bot/Bot.tscn").instance()
		else:
			_p3 = load("res://Player/Player.tscn").instance()
			
	if _gameInfo.P4.isPlaying :
		if _gameInfo.P4.isBot :
			_p4 = load("res://Bot/Bot.tscn").instance()
		else:
			_p4 = load("res://Player/Player.tscn").instance()
	
	var _players=[_p1,_p2,_p3,_p4]
	
	var j = 0
	for i in _players :
			if i:
				add_child(i)
				i.playerID= "P"+str(j+1)
				i.position=_positions[j]
			j+=1
	
	
	
	resizeCount = 1
	resizeTime = Timer.new()
	resizeTime.start(30)
	add_child(resizeTime)
	resizeTime.connect("timeout", self, "_on_resizeTime_timeout")


func _on_resizeTime_timeout():
	resize()
	
func _process(delta):
	pass