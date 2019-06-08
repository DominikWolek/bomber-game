extends "res://addons/gut/test.gd"

class TestHighScore:
	extends "res://addons/gut/test.gd"
	
	var _highscore = load("res://Highscore/Highscore.tscn")
	var file_name = "res://high.score"
	var MAX_SIZE = 10
	var table = []
	var _ScorePair = load("res://Highscore/ScorePair.gd")
	var highscore
	
	var nicknames = ['nick1', '2', 'ASDASVASFFADF', 'ASDHFJHck4*&^%$##$DSAJKJ', '4355fbcvnąąąąććźźź', 'blabla6', 'spnko7', 'kiermasz8', 'winner9', 'chicken10', 'dinner11']
	var results = [11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
	
	func test_get_list():
		var highscore = _highscore.instance()
		assert_file_exists(file_name)
		assert_eq(len(nicknames), len(results))
		
		var file = File.new()
		file.open(file_name, file.WRITE)
		file.store_line(str(len(nicknames)))
		for i in range(len(nicknames)):
			file.store_line(nicknames[i])
			file.store_line(str(results[i]))
		file.close()
		var t = highscore.get_list()
		assert_eq(len(t), len(nicknames))
		for i in range(len(t)):
			assert_eq(t[i].nickname, nicknames[i])
			assert_eq(t[i].score, results[i])
		
		file = File.new()
		file.open(file_name, file.WRITE)
		file.close()
		t = highscore.get_list()
		assert_eq(1, len(t))
#		assert_eq(t[0].score, 0)
#		assert_eq(t[0].nickname, '_')
	
	func test_try_to_add():
		var highscore = _highscore.instance()
		assert_file_exists(file_name)
		assert_eq(len(nicknames), len(results))
		
		var file = File.new()
		highscore.reset()
		
		for i in range(len(nicknames)):
			if i < MAX_SIZE:
				assert_true(highscore.try_to_add(nicknames[i], results[i]))
			else:
				assert_false(highscore.try_to_add(nicknames[i], results[i]))

	func test_reset():
		var highscore = _highscore.instance()
		highscore.reset()
		assert_file_empty(file_name)
