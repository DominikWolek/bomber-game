extends "res://addons/gut/test.gd"

class TestBoard:
	extends "res://addons/gut/test.gd"

	var _board = load("res://Board/Board.tscn")
	var _sparks = load("res://Board/explosionParticle.tscn")
	var _bomb = load("res://Board/bomb.tscn")
	var _light = load("res://Board/Light2D.tscn")
	var _player = load("res://Player/Player.tscn")
	var board

	var MAX_RESIZE_COUNT = 5

	func test_bumv():
		pending()
#		var sparks
#		var leng
#		var pos
#		var step
#		dangerList = Array()
#
#		light = _light.instance()
#		light.position = map_to_world(world_to_map(initialPos)) + Vector2(32, 32)
#		add_child(light)
#		Sounds.get_node("Explosion").position = initialPos
#		Sounds.get_node("Explosion").play()
#
#		sparks = _sparks.instance()
#		sparks.position = map_to_world(world_to_map(initialPos)) + Vector2(32, 32)
#		dangerList.append(world_to_map(initialPos))
#		add_child(sparks) 
#		sparks.set_one_shot(true)
#		sparks.set_emitting(true)		
#
#		for i in range(4):
#			leng = damageList[player]
#			pos = initialPos
#			if (i == 0):
#				step = Vector2(-64, 0)
#			elif (i == 1):
#				step = Vector2(0, 64)
#			elif (i == 2):
#				step = Vector2(64, 0)
#			elif (i == 3):
#				step = Vector2(0, -64)
#			pos += step
#			while get_cellv(world_to_map(pos)) != 0 and leng !=0   :
#				if(get_cellv(world_to_map(pos)) == 2):
#					scores[player] += 1
#					set_cellv(world_to_map(pos), 1)
#					leng = 1
#					spawnPowerUP(pos)
#				sparks = _sparks.instance()
#				sparks.position = map_to_world(world_to_map(pos)) + Vector2(32, 32)
#				dangerList.append(world_to_map(pos))
#				add_child(sparks) 
#				sparks.set_one_shot(true)
#				sparks.set_emitting(true)
#				leng -= 1
#				pos += step
#
#		emit_signal("explosion", dangerList, player)

	func test_place_bomb():
		pending()
		board = _board.instance()
		var player = _player.instance()

		var pos = Vector2(96,96)

		var b = board.get_node('Board')
		var bomb = b.place_bomb(pos, player)
		assert_true(true)
		assert_eq(bomb.placedBy, player)
#		assert_eq(bomb.position, TileMap.instance().map_to_world(TileMap.instance().world_to_map(pos)) + Vector2(32, 32))



#		bomb.placedBy = player
#		bomb.position = map_to_world(world_to_map(initialPos)) + Vector2(32, 32)
#		add_child(bomb)


	func test_resize():
#		board = _board.instance()
#		board.resize()
#		var a = board.get_child(-1)
#		assert_true(true)
		pending()
#		if(resizeCount <=5):
#			var _collapse = load("res://Board/Collapses/Collapse"+str(resizeCount)+".tscn")
#			var collapse = _collapse.instance()
#			add_child(collapse)
#			resizeCount += 1

	func test_resize_count_plus_one():
		pending()		

	func test_resize_count_over_max():
#		board = _board.instance()
#		for i in range(MAX_RESIZE_COUNT):
#			board.resize()
		pending()






	func test_shuffleList():
		pending()
#		var shuffledList = []
#		randomize()
#		var indexList = range(list.size())
#		for i in range(list.size()):
#			var x = randi()%indexList.size()
#			shuffledList.append(list[indexList[x]])
#			indexList.remove(x)
#		return shuffledList


	func test__ready():
		pending()
#		Sounds.get_node("MainMenu").stop()
#		if (ConfigurationNode._get_value("Sounds", "soundSwitch")):
#			Sounds.get_node("GamePlay").play()
#
#		var _gameInfo = get_node("/root/ConfigurationNode").gameInfo
#
#		if(_gameInfo["map"]["map_type"] == 1):
#			set_tileset(load("res://Assets/TileSets/Dirt.tres"))
#		elif(_gameInfo["map"]["map_type"] == 2):
#			set_tileset(load("res://Assets/TileSets/Wood.tres"))
#		elif(_gameInfo["map"]["map_type"] == 3):
#			set_tileset(load("res://Assets/TileSets/Water.tres"))
#		elif(_gameInfo["map"]["map_type"] == 4):
#			set_tileset(load("res://Assets/TileSets/Desert.tres"))
#		elif(_gameInfo["map"]["map_type"] == 5):
#			set_tileset(load("res://Assets/TileSets/Grass.tres"))
#		else: set_tileset(load("res://Assets/TileSets/Dirt.tres"))
#
#		var _pos1 = Vector2( 64+32, 64+32 ) 
#		var _pos2 = Vector2( 64*13+32, 64+32 )
#		var _pos3 = Vector2( 64+32 , 10*64 - 32 )
#		var _pos4 = Vector2( 64*13 +32 ,10*64-32 )
#
#
#
#		var _positions = [_pos1,_pos2,_pos3,_pos4]
#		_positions = shuffleList(_positions)
#
#		var _p1
#		var _p2
#		var _p3
#		var _p4
#
#
#		_p1 = load("res://Player/Player.tscn").instance()
#
#		if _gameInfo["P2"]["is_playing"] :
#			if _gameInfo["P2"]["is_bot"] :
#				_p2 = load("res://Bot/Bot.tscn").instance()
#			else:
#				_p2 = load("res://Player/Player.tscn").instance()
#
#		if _gameInfo["P3"]["is_playing"] :
#			if _gameInfo["P3"]["is_bot"] :
#				_p3 = load("res://Bot/Bot.tscn").instance()
#			else:
#				_p3 = load("res://Player/Player.tscn").instance()
#
#		if _gameInfo["P4"]["is_playing"] :
#			if _gameInfo["P4"]["is_bot"] :
#				_p4 = load("res://Bot/Bot.tscn").instance()
#			else:
#				_p4 = load("res://Player/Player.tscn").instance()
#
#		var _players=[_p1,_p2,_p3,_p4]
#
#		var j = 0
#		var playerCount = 0
#		for i in _players :
#
#			if i:
#				playerCount  += 1
#				add_child(i)
#				i.playerID = "P"+str(j+1)
#				scores[i.playerID] = 0
#				i.Name = get_node("/root/ConfigurationNode")._get_value("P"+str(j+1),"name")
#				playerNames[i.playerID] = i.Name
#				i.position=_positions[j]
#				var colour = get_node("/root/ConfigurationNode")._get_value("P"+str(j+1),"colour")
#				if colour == 0:
#					i.colour = Color(0,0,0,1)
#				elif colour == 1:
#					i.colour = Color( 0.8, 0.36, 0.36, 1 )
#				elif colour == 2:
#					i.colour = Color( 0.69, 0.88, 0.9, 1 )
#				elif colour == 3:
#					i.colour = Color( 0.6, 0.98, 0.6, 1 )
#				elif colour == 4:
#					i.colour = Color( 1, 1, 0, 1 )
#				elif colour == 5:
#					i.colour = Color( 0.55, 0.55, 0.55, 1 )
#				elif colour == 6:
#					i.colour = Color( 1, 0.41, 0.71, 1 )
#				i._check_colour()
#				i.score = 0
#			j+=1
#
#		activePlayers = playerCount
#		resizeCount = 1
#		resizeTime = Timer.new()
#		resizeTime.start(45)
#		add_child(resizeTime)
#		resizeTime.connect("timeout", self, "_on_resizeTime_timeout")

	func test_winnerWinnerChickenDinner():
		pending()
#		var _ScorePair = load("res://Highscore/ScorePair.gd")
#		var ScorePair
#		var scoresArr: Array
#		for i in scores.keys():
#			ScorePair = _ScorePair.new()
#			ScorePair.nickname = i
#			ScorePair.score = scores[i]
#			scoresArr.append(ScorePair)
#
#
#
#		var endMessage : String
#		if(scoresArr[0].score != scoresArr[1].score): #if two players have the same score
#		#we don't save it
#			endMessage = "Congratulations " + playerNames[scoresArr[0].nickname] + "!\r\nYou've scored "+str(scoresArr[0].score) + " points, " 
#			if(Highscore.tryToAdd(playerNames[scoresArr[0].nickname], scoresArr[0].score)):
#				endMessage += "and you've managed to get into the highscore list!"
#			else:
#				endMessage += "but you didn't make it into the highscore list!"
#		else:
#			endMessage = "We have a tie!\r\n" + playerNames[scoresArr[0].nickname] + " and " + playerNames[scoresArr[1].nickname] + " both have " +str(scoresArr[0].score) + " points." 
#		var _endLabel = load("res://Board/Endgame.tscn")
#		var endLabel = _endLabel.instance()
#		endLabel.add(endMessage)
#		add_child(endLabel)
#
#		#Sounds.get_node("GamePlay").stop()
#		#maybe some other things