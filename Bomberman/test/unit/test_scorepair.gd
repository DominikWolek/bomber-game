extends "res://addons/gut/test.gd"

class TestScorePair:
	extends "res://addons/gut/test.gd"

	var nickname
	var score

	var _scorepair = load("res://Highscore/ScorePair.gd")
	# more cases
	func test_sort():
		var scorepair = _scorepair.new()
		var a = _scorepair.new()
		var b = _scorepair.new()
		a.score = 1
		b.score = 12

		assert_false(scorepair.sort(a, b))
		assert_true(scorepair.sort(b, a))
		
		b.score = a.score
		assert_true(scorepair.sort(a, b))