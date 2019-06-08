extends "res://addons/gut/test.gd"

class TestPlayer:
	extends "res://addons/gut/test.gd"
	var _player = load("res://Player/Player.tscn")
	var player
	
	var INITIAL_NUMBER_OF_BOMBS = 1
	var INITIAL_HP = 3
	var INITIAL_IMMORTALITY = false
	var INITIAL_BOMB_DMG = 1
	var INITIAL_COLOR = Color(0, 0, 0)
	var INITIAL_PLAYER_ID = "P5"
	var INITIAL_DANGER_LIST = Array()
	var INITIAL_SPEED = 200
	var INITIAL_VELOCITY = Vector2()
	var INITIAL_NAME = "nickname"
	var SPEED_CHANGE = 70
	var BOMB_DELAY = 3
	var LIMIT = 10    

	func test_set_couple_nicknames():
		player = _player.instance()
		var names = ['A', 'bbbxcb', '23123', 'ASkdj123][FFFFFFF;/aFSDsd']
		for name in names:
			player.set_nickname(name)
			assert_eq(player.name, name)

	func test_addBomb():
		player = _player.instance()
		for i in range(LIMIT):
			player = _player.instance()
			for j in range(i):
				player.add_bomb()
			assert_eq(player.can_plant, INITIAL_NUMBER_OF_BOMBS + i)
	
	func test_speedUP_add_limit_times():
		player = _player.instance()
		for i in range(LIMIT):
			player = _player.instance()
			for j in range(i):
				player.speed_up()
			assert_eq(player.speed, INITIAL_SPEED + i * SPEED_CHANGE)
	
	func test_speedUP_add_one_time():
		player = _player.instance()
		player = _player.instance()
		player.speed_up()
		assert_eq(player.speed, INITIAL_SPEED + SPEED_CHANGE)
	
	func test_increaseDMG_limit_times():
		for i in range(LIMIT):
			player = _player.instance()
			for j in range(i):
				player.increase_dmg()
			assert_eq(player.bomb_dmg, INITIAL_BOMB_DMG + i)

	func test_increaseDMG_one_time():
		player = _player.instance()
		player.increase_dmg()
		assert_eq(player.bomb_dmg, INITIAL_BOMB_DMG + 1)
		
	func test_notImmortal():
		player = _player.instance()
		assert_eq(player.is_immortal, INITIAL_IMMORTALITY)
		player.not_immortal()
		assert_false(player.is_immortal)
		
	func test_check_color():
		player = _player.instance()
		player.color = Color(0, 0, 0, 1)
		player._check_color()
		assert_ne(player.modulate, Color(0, 0, 0, 1))
		player.color = Color(0, 0, 1, 0)
		player._check_color()
		assert_eq(player.modulate, Color(0, 0, 1, 0))
		
	func test_winner():
		pending()
		player = _player.instance()
		player.dead = false
		player.score = 100000000
		Highscore.reset()
		player.winner()
		var scorepairs = Highscore.get_list()
		var scores = []
		for sp in scorepairs:
			scores.append(sp.score)
		assert_has(scores, player.score)
		Highscore.reset()
		
		
		