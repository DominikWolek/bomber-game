#extends "res://addons/gut/test.gd"
#
#var passedTests = 0
#var totalTests = 0
#
#class TestBot:
#	extends "res://addons/gut/test.gd"
#	var _player = load("res://Player/Player.tscn")
#	var _board = load("res://Board/Board.tscn")
#	var _ScorePair = load("res://Highscore/ScorePair.tscn")
#	var player
#	var score
#	var board
#
#	var INITIAL_NUMBER_OF_BOMBS = 1
#	var INITIAL_HP = 3
#	var INITIAL_IMMORTALITY = false
#	var INITIAL_BOMB_DMG = 1
#	var INITIAL_COLOR = Color(0, 0, 0)
#	var INITIAL_PLAYER_ID = "P5"
#	var INITIAL_DANGER_LIST = Array()
#	var INITIAL_SPEED = 200
#	var INITIAL_VELOCITY = Vector2()
#
#	var SPEED_CHANGE = 70
#	var BOMB_DELAY = 3
#	var LIMIT = 10    
#
#	func test_set_couple_nicknames():
#		player = _player.instance()
#		var names = ['A', 1, 'bbbxcb', '23123', 'ASkdj123][FFFFFFF;/aFSDsd']
#		for name in names:
#			player.setNickname(name)
#			assert_eq(player.Name, name)
#
#
#	func test_addBomb():
#		player = _player.instance()
#		for i in range(LIMIT):
#			player = _player.instance()
#			for j in range(i):
#				player.addBomb()
#			assert_eq(player.canPlant, INITIAL_NUMBER_OF_BOMBS + i)
#
#
#	func test_speedUP_add_limit_times():
#		player = _player.instance()
#		for i in range(LIMIT):
#			player = _player.instance()
#			for j in range(i):
#				player.speedUP()
#			assert_eq(player.speed, INITIAL_SPEED + i * SPEED_CHANGE)
#
#
#	func test_speedUP_add_one_time():
#		player = _player.instance()
#		player = _player.instance()
#		player.speedUP()
#		assert_eq(player.speed, INITIAL_SPEED + SPEED_CHANGE)
#
#
#	func test_increaseDMG_limit_times():
#		for i in range(LIMIT):
#			player = _player.instance()
#			for j in range(i):
#				player.increaseDMG()
#			assert_eq(player.bombDMG, INITIAL_BOMB_DMG + i)
#
#
#	func test_increaseDMG_one_time():
#		player = _player.instance()
#		player.increaseDMG()
#		assert_eq(player.bombDMG, INITIAL_BOMB_DMG + 1)
#
#	func test_winner():
#		player = _player.instance()
#		player.score = -1
#		player.winner()
#		pending()
#
#