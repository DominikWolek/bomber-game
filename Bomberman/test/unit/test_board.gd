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

	func test_place_bomb():
		board = _board.instance().get_node("Board")
		var player = _player.instance()
		var pos = Vector2(96,96)
		var bomb = board.place_bomb(pos, player)
		assert_eq(bomb.placed_by, player)

	func test_step():
		board = _board.instance().get_node("Board")
		assert_eq(board.step(0), Vector2(-64, 0))
		assert_eq(board.step(1), Vector2(0, 64))
		assert_eq(board.step(2), Vector2(64, 0))
		assert_eq(board.step(3), Vector2(0, -64))

	func test_load_map():
		assert_file_exists("res://Assets/TileSets/Dirt.tres")
		assert_file_exists("res://Assets/TileSets/Wood.tres")
		assert_file_exists("res://Assets/TileSets/Water.tres")
		assert_file_exists("res://Assets/TileSets/Desert.tres")
		assert_file_exists("res://Assets/TileSets/Grass.tres")

	func test_get_color():
		board = _board.instance().get_node("Board")
		var c_a = board.get_color()
		var expected = [Color(0,0,0,1), Color( 0.8, 0.36, 0.36, 1 ), Color( 0.69, 0.88, 0.9, 1 ), Color( 0.6, 0.98, 0.6, 1 ), Color( 1, 1, 0, 1 ), Color( 0.55, 0.55, 0.55, 1 ), Color( 1, 0.41, 0.71, 1 )]
		assert_eq(len(c_a), len(expected))
		for i in range(len(c_a)):
			assert_eq(c_a[i], expected[i])	
