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

# test for private function
	func test_physics_process():
		bot = _bot.instance()
		var delta = [[2, 0], [-2, 0], [0, 2], [0, -2]]
		assert_eq(len(delta), len(directions))
		
		for i in range(len(directions)):
			bot.direction = directions[i]
			bot.position.x = bot.position_to_achieve.x + delta[i][0]
			bot.position.y = bot.position_to_achieve.y + delta[i][1]
			bot._physics_process(1)
			assert_false(bot.moving)
			if delta[i][0] == 1:
				assert_eq(bot.position.x, bot.position_to_achieve.x)
			if delta[i][1] == 1:
				assert_eq(bot.position.y, bot.position_to_achieve.y)
				
			bot.position.x = bot.position_to_achieve.x - delta[i][0]
			bot.position.y = bot.position_to_achieve.y - delta[i][1]
			bot._physics_process(1)
			assert_false(bot.moving)
			if delta[i][0] == 1:
				assert_ne(bot.position.x, bot.position_to_achieve.x)
			if delta[i][1] == 1:
				assert_ne(bot.position.y, bot.position_to_achieve.y)
