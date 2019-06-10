extends "res://addons/gut/test.gd"

class TestPanel:
	extends "res://addons/gut/test.gd"
	var _panel = load("res://GUI/Character Selection/Panel.gd")
	var panel
	
	func test_name_correct():
		var valid = ['blabla', '123321', '1111', 'aaaa', 'As3Z']
		var unvalid = ['fghkjlk;ll;kljkhgf', 'A', '1', '123', 'abc', 'qqqqqqqqqqqqqqqqqqqqqqqqq']
		
		panel = _panel.new()
		for name in valid:
			assert_true(panel.name_correct(name))
			
		for name in unvalid:
			assert_false(panel.name_correct(name))
