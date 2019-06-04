extends TileMap

var _sparks = load("res://Board/explosionParticle.tscn")
var _bomb = load("res://Board/bomb.tscn")
var _light = load("res://Board/Light2D.tscn")


var hitmark
var bomb
var light
var danger_list

var bombsCount

var resizeCount
var resizeTime

var damageList: Dictionary

var activePlayers
var scores : Dictionary
var playerNames: Dictionary

signal explosion( danger_list, Player)
signal winnerWinnerChickenDinner()

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

func cellv_from_position(position):
	return get_cellv(world_to_map(position))

func bumv(initialPos, player):
	var sparks
	var leng
	var pos
	var step
	danger_list = Array()
	
	light = _light.instance()
	light.position = map_to_world(world_to_map(initialPos)) + Vector2(32, 32)
	add_child(light)
	Sounds.get_node("Explosion").position = initialPos
	Sounds.get_node("Explosion").play()
	
	sparks = _sparks.instance()
	sparks.position = map_to_world(world_to_map(initialPos)) + Vector2(32, 32)
	danger_list.append(world_to_map(initialPos))
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
				scores[player] += 1
				set_cellv(world_to_map(pos), 1)
				leng = 1
				spawnPowerUP(pos)
			sparks = _sparks.instance()
			sparks.position = map_to_world(world_to_map(pos)) + Vector2(32, 32)
			danger_list.append(world_to_map(pos))
			add_child(sparks) 
			sparks.set_one_shot(true)
			sparks.set_emitting(true)
			leng -= 1
			pos += step
	
	emit_signal("explosion", danger_list, player)

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
	if (ConfigurationNode.get_value("Sounds", "soundSwitch")):
		Sounds.get_node("GamePlay").play()
	
	var game_info = get_node("/root/ConfigurationNode").game_info
	
	if(game_info["map"]["map_type"] == 1):
		set_tileset(load("res://Assets/TileSets/Dirt.tres"))
	elif(game_info["map"]["map_type"] == 2):
		set_tileset(load("res://Assets/TileSets/Wood.tres"))
	elif(game_info["map"]["map_type"] == 3):
		set_tileset(load("res://Assets/TileSets/Water.tres"))
	elif(game_info["map"]["map_type"] == 4):
		set_tileset(load("res://Assets/TileSets/Desert.tres"))
	elif(game_info["map"]["map_type"] == 5):
		set_tileset(load("res://Assets/TileSets/Grass.tres"))
	else: set_tileset(load("res://Assets/TileSets/Dirt.tres"))
	
	var _pos1 = Vector2( 64+32, 64+32 ) 
	var _pos2 = Vector2( 64*13+32, 64+32 )
	var _pos3 = Vector2( 64+32 , 10*64 - 32 )
	var _pos4 = Vector2( 64*13 +32 ,10*64-32 )
	
	
	
	var _positions = [_pos1,_pos2,_pos3,_pos4]
	_positions = shuffleList(_positions)
	
	var _p1
	var _p2
	var _p3
	var _p4
	
	
	_p1 = load("res://Player/Player.tscn").instance()
	
	if game_info["P2"]["is_playing"] :
		if game_info["P2"]["is_bot"] :
			_p2 = load("res://Bot/Bot.tscn").instance()
		else:
			_p2 = load("res://Player/Player.tscn").instance()
	
	if game_info["P3"]["is_playing"] :
		if game_info["P3"]["is_bot"] :
			_p3 = load("res://Bot/Bot.tscn").instance()
		else:
			_p3 = load("res://Player/Player.tscn").instance()
			
	if game_info["P4"]["is_playing"] :
		if game_info["P4"]["is_bot"] :
			_p4 = load("res://Bot/Bot.tscn").instance()
		else:
			_p4 = load("res://Player/Player.tscn").instance()
	
	var _players=[_p1,_p2,_p3,_p4]
	
	var j = 0
	var playerCount = 0
	for i in _players :

		if i:
			playerCount  += 1
			add_child(i)
			i.player_id = "P"+str(j+1)
			scores[i.player_id] = 0
			i.name = get_node("/root/ConfigurationNode").get_value("P"+str(j+1),"name")
			playerNames[i.player_id] = i.name
			i.position=_positions[j]
			var color = get_node("/root/ConfigurationNode").get_value("P"+str(j+1),"color")
			if color == 0:
				i.color = Color(0,0,0,1)
			elif color == 1:
				i.color = Color( 0.8, 0.36, 0.36, 1 )
			elif color == 2:
				i.color = Color( 0.69, 0.88, 0.9, 1 )
			elif color == 3:
				i.color = Color( 0.6, 0.98, 0.6, 1 )
			elif color == 4:
				i.color = Color( 1, 1, 0, 1 )
			elif color == 5:
				i.color = Color( 0.55, 0.55, 0.55, 1 )
			elif color == 6:
				i.color = Color( 1, 0.41, 0.71, 1 )
			i._check_color()
			i.score = 0
		j+=1
	
	activePlayers = playerCount
	resizeCount = 1
	resizeTime = Timer.new()
	resizeTime.start(45)
	add_child(resizeTime)
	resizeTime.connect("timeout", self, "_on_resizeTime_timeout")

func winnerWinnerChickenDinner():
	var _ScorePair = load("res://Highscore/ScorePair.gd")
	var ScorePair
	var scoresArr: Array
	for i in scores.keys():
		ScorePair = _ScorePair.new()
		ScorePair.nickname = i
		ScorePair.score = scores[i]
		scoresArr.append(ScorePair)
	var endMessage : String
	if(scoresArr[0].score != scoresArr[1].score): #if two players have the same score
	#we don't save it
		endMessage = "Congratulations " + playerNames[scoresArr[0].nickname] + "!\r\nYou've scored "+str(scoresArr[0].score) + " points, " 
		if(Highscore.tryToAdd(playerNames[scoresArr[0].nickname], scoresArr[0].score)):
			endMessage += "and you've managed to get into the highscore list!"
		else:
			endMessage += "but you didn't make it into the highscore list!"
	else:
		endMessage = "We have a tie!\r\n" + playerNames[scoresArr[0].nickname] + " and " + playerNames[scoresArr[1].nickname] + " both have " +str(scoresArr[0].score) + " points." 
	var _endLabel = load("res://Board/Endgame.tscn")
	var endLabel = _endLabel.instance()
	endLabel.add(endMessage)
	add_child(endLabel)
	
	#Sounds.get_node("GamePlay").stop()
	#maybe some other things
	
func _on_resizeTime_timeout():
	resize()
	
func _process(delta):
	pass
		