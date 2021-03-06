extends TextureRect
var map = 0

func _ready():
	map = get_node("/root/ConfigurationNode").get_value("map","map_type")
	if (map < 1 or map > 5):
		map = 1
		get_node("/root/ConfigurationNode").change_and_commit("map","map_type",map)
	self.texture = load("res://Assets/"+String(map)+".PNG")

func next_map():
	map = (map+1) % 5
	if (map == 0):
		map = 5
	self.texture = load("res://Assets/"+String(map)+".PNG")
	get_node("/root/ConfigurationNode").change_and_commit("map","map_type",map)

func prev_map():
	map = (map-1) % 5
	if (map == 0):
		map = 5
	self.texture = load("res://Assets/"+String(map)+".PNG")
	get_node("/root/ConfigurationNode").change_and_commit("map","map_type",map)