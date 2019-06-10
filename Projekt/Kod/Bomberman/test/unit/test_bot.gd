extends "res://addons/gut/test.gd"

class TestBot:
	extends "res://addons/gut/test.gd"
	var _bot = load("res://Bot/Bot.tscn")
	var bot
	var directions = ["right", "left", "up", "down"]
	
	func test_possible_plant():
		bot = _bot.instance()
		bot.can_plant = 0
		assert_false(bot.possible_plant(bot.position_to_achieve))

	func test_opposite_direction():
		bot = _bot.instance()
		var expected = ["left", "right", "down", "up"]
		assert_eq(len(directions), len(expected))
		for i in range(len(directions)):
			bot.direction = expected[i]
			assert_eq(directions[i], bot.opposite_direction())