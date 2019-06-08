extends "res://addons/gut/test.gd"

class TestBot:
	extends "res://addons/gut/test.gd"
	var _bot = load("res://Bot/Bot.tscn")
	var _board = load("res://Board/Board.tscn")
	var _ScorePair = load("res://Highscore/ScorePair.gd")
	var bot
	var score
	var board

	var INITIAL_NUMBER_OF_BOMBS = 1
	var INITIAL_NAME = "nickname"
	var INITIAL_HP = 3
	var INITIAL_IMMORTALITY = false
	var INITIAL_BOMB_DMG = 1
	var INITIAL_COLOR = Color(0, 0, 0)
	var INITIAL_PLAYER_ID = "P5"
	var INITIAL_DANGER_LIST = Array()
	var INITIAL_SPEED = 200
	var INITIAL_VELOCITY = Vector2()

	var SPEED_CHANGE = 70
	var BOMB_DELAY = 3
	var LIMIT = 10    
	
	func check_canPlant_after_timeout():
		pending()
##		assert_eq(bot.canPlant, INITIAL_NUMBER_OF_BOMBS)
#
#	func test_plant_bomb_can_plant():
#		pending()
#		board = _board.instance()
#		bot = _bot.instance()
#		board.add_child(bot)
#		var timer = Timer.new()
#		timer.set_one_shot(true)
#		timer.set_wait_time(BOMB_DELAY)
#		timer.connect("timeout", self, "_check_canPlant_after_timeout")
##		bot.plant_bomb()
#		timer.start()
#		assert_eq(bot.canPlant, INITIAL_NUMBER_OF_BOMBS - 1)
#

#	if canPlant > 0: # jeśli jest jakas bomba do podłożenia
#		canPlant -= 1
#		get_parent().place_bomb(position, playerID)
#		var timer = Timer.new()
#		timer.set_one_shot(true)
#		timer.set_wait_time(3) # po 3 sekundach wybucha bomba
#		timer.connect("timeout",self,"addBomb")
#		add_child(timer)
#		timer.start()


	func test_immediateDeath(): # przy zmniejszaniu sie mapy
		pending()
#		bot = _bot.instance()
#		var p = bot.get_parent()
#		assert_not_null(p)
#		bot.immediateDeath()
#		bot = _bot.instance()
#		assert_eq(bot.hp, 0)
#		assert_eq(bot.dead, true)
#		assert_eq(Sounds.get_node("Death").position, bot.position)
#		assert_eq(p.activePlayers - 1, bot.get_parent().activePlayers)
#


#		hp = 0
#		dead = true
#		Sounds.get_node("Death").position = position
#		Sounds.get_node("Death").play()
#		get_parent().activePlayers -= 1
#		if(get_parent().activePlayers == 1):
#			get_parent().winnerWinnerChickenDinner()
#		queue_free()

	func test_exploded():
		pending()
#		bot = _bot.instance()
#		bot.isImmortal = false
#		bot.exploded('bot')
#		assert_true(bot.isImmortal)
#		assert_eq(Sounds.get_node("Damage").position, bot.position)
#




#		if isImmortal:
#			return
#		else:
#			isImmortal = true
#			Sounds.get_node("Damage").position = position
#			Sounds.get_node("Damage").play()
#			# ewentualny zapis statystyk dla gracza by_who
#			if(by_who != playerID):
#				get_parent().scores[by_who] += 10
#			hp -= 1
#			if hp == 0:
#				if(by_who != playerID):
#					get_parent().scores[by_who] += 10
#				immediateDeath()
#			else:
#				var timer = Timer.new()
#				timer.set_one_shot(true)
#				timer.set_wait_time(2) #2 sekundowa niesmiertelnosc
#				timer.connect("timeout",self,"notImmortal")
#				add_child(timer)
#				timer.start()
#
	func test_ready():
		pending()
#		bot = _bot.instance()
#		bot._ready()
#		assert_false(bot.dead)
#		assert_eq(bot.score, 0)

#		dead = false
#		score  = 0
#		get_parent().connect("explosion", self, "_on_Bomb_explosion", dangerList, player)
#		randomize()
#		get_parent().connect("winnerWinnerChickenDinner", self, "winner")



	func test_on_Bomb_explosion():
		pending()
#		for i in dangerList:
#			if ( i == get_parent().world_to_map(position)):
#				exploded(player)
#
#	var position_to_achieve = position
#	var moving = false
#	var direction = -1
#	var stop = true
#
	func test_direction():
		pending()
#		var num = 0
#		var array = [false,false,false,false]
#		var right = 0
#		var left = 0
#		var up = 0
#		var down = 0
#		if (get_parent().get_cellv(get_parent().world_to_map(position+Vector2(64,0)))!=2 and get_parent().get_cellv(get_parent().world_to_map(position+Vector2(64,0)))!=0): #jesli nie jest to skrzynka ani niezniszczalny obiekt (po prawej)
#			array[num] = true
#			if (prev_dir == 1):
#				right = 2
#			else: right = 10
#		num += 1
#		if (get_parent().get_cellv(get_parent().world_to_map(position+Vector2(-64,0)))!=2 and get_parent().get_cellv(get_parent().world_to_map(position+Vector2(-64,0)))!=0): #jesli nie jest to skrzynka ani niezniszczalny obiekt (po lewej)
#			array[num] = true
#			if (prev_dir == 0):
#				left = 2
#			else: left = 10
#		left += right
#		num += 1
#		if (get_parent().get_cellv(get_parent().world_to_map(position+Vector2(0,-64)))!=2 and get_parent().get_cellv(get_parent().world_to_map(position+Vector2(0,-64)))!=0): #jesli nie jest to skrzynka ani niezniszczalny obiekt (powyzej)
#			array[num] = true
#			if (prev_dir == 3):
#				up = 2
#			else: up = 10
#		up += left
#		num += 1
#		if (get_parent().get_cellv(get_parent().world_to_map(position+Vector2(0,64)))!=2 and get_parent().get_cellv(get_parent().world_to_map(position+Vector2(0,64)))!=0): #jesli nie jest to skrzynka ani niezniszczalny obiekt (ponizej)
#			array[num] = true
#			if (prev_dir == 2):
#				down = 2
#			else: down = 10
#		down += up
#		randomize()
#		var random_number = randi()% down
#		if (random_number < right):
#			return 0
#		elif (random_number < left):
#			return 1
#		elif (random_number < up):
#			return 2
#		else:
#			return 3

	func test_possiblePlant():
		pending()
#		if canPlant>0:
#			var index
#			for i in range(bombDMG):
#				index = get_parent().get_cellv(get_parent().world_to_map(position+(i+1)*Vector2(64,0)))
#				if (index == 2):
#					return true
#				elif (index == 0):
#					break
#			for i in range(bombDMG):
#				index = get_parent().get_cellv(get_parent().world_to_map(position+(i+1)*Vector2(-64,0)))
#				if (index == 2):
#					return true
#				elif (index == 0):
#					break
#			for i in range(bombDMG):
#				index = get_parent().get_cellv(get_parent().world_to_map(position+(i+1)*Vector2(0,-64)))
#				if (index == 2):
#					return true
#				elif (index == 0):
#					break
#			for i in range(bombDMG):
#				index = get_parent().get_cellv(get_parent().world_to_map(position+(i+1)*Vector2(0,64)))
#				if (index == 2):
#					return true
#				elif (index == 0):
#					break
#		return false

	func test_get_input():
		pending()



#		if moving == false:
#			if (possiblePlant(position)):
#				plant_bomb()
#				if (direction == 0):
#					direction = 1
#				elif (direction == 1):
#					direction = 0
#				elif (direction == 2):
#					direction = 3
#				elif (direction == 3): 
#					direction = 2
#				else: direction = _direction(position, direction)
#			else: 
#				direction = _direction(position, direction)
#			moving = true
#			if (direction == 0):
#				velocity.x += 1
#				position_to_achieve = position + Vector2(64,0)
#			elif (direction == 1):
#				velocity.x -= 1
#				position_to_achieve = position + Vector2(-64,0)
#			elif (direction == 2):
#				velocity.y -= 1
#				position_to_achieve = position + Vector2(0,-64)
#			else: 
#				velocity.y += 1
#				position_to_achieve = position + Vector2(0,64)
#			velocity = velocity.normalized() * speed
#
#			var temp = ""	
#			if (isImmortal):
#				temp = "_IMMORTAL"
#			if direction == 0:
#				$Sprite.flip_h = false
#				$Sprite.play("run"+temp)
#			elif direction == 1:
#				$Sprite.flip_h = true
#				$Sprite.play("run"+temp)
#			#elif Input.is_action_pressed('ui_down') and Input.is_action_pressed('ui_up'):
#			#	$Sprite.play("idle"+temp)
#			elif direction == 3:
#				$Sprite.play("runDOWN"+temp)
#			elif direction == 2:
#				$Sprite.play("runUP"+temp)
#			else: $Sprite.play("idle"+temp)

	func test_physics_process():
		pending()
#		get_parent().damageList[playerID] = bombDMG
#		get_input()
#		move_and_slide(velocity)
#		if (direction == 0):
#			if (position.x > position_to_achieve.x):
#				position.x = position_to_achieve.x
#				moving = false
#				velocity = Vector2()
#		if (direction == 1):
#			if (position.x < position_to_achieve.x):
#				position.x = position_to_achieve.x
#				moving = false
#				velocity = Vector2()
#		if (direction == 2):
#			if (position.y < position_to_achieve.y):
#				position.y = position_to_achieve.y
#				moving = false
#				velocity = Vector2()
#		if (direction == 3):
#			if (position.y > position_to_achieve.y):
#				position.y = position_to_achieve.y
#				moving = false
#				velocity = Vector2()
