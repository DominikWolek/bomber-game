extends "res://addons/gut/test.gd"

var passedTests = 0
var totalTests = 0

class TestBot:
	extends "res://addons/gut/test.gd"
	var _player = load("res://Player/Player.tscn")
	var _board = load("res://Board/Board.tscn")
	var _ScorePair = load("res://Highscore/ScorePair.tscn")
	var player
	var score
	var board
	
	var INITIAL_NUMBER_OF_BOMBS = 1
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

	func test_set_couple_nicknames():
		player = _player.instance()
		var names = ['A', 1, 'bbbxcb', '23123', 'ASkdj123][FFFFFFF;/aFSDsd']
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