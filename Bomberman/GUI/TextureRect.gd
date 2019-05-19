extends TextureRect
var map = 0
var image
var tex
func _ready():
	map = get_node("/root/ConfigurationNode")._get_value("map","map_type")
	if (map < 1 or map > 5):
		map = 1
		get_node("/root/ConfigurationNode")._change_and_commit("map","map_type",map)
	image = Image.new()
	image.load("res://GUI/"+String(map)+".PNG")
	tex = ImageTexture.new()
	tex.create_from_image(image)
	texture = tex

func next_map():
	map = (map+1) % 5
	if (map == 0):
		map = 5
	image = Image.new()
	image.load("res://GUI/"+String(map)+".PNG")
	tex = ImageTexture.new()
	tex.create_from_image(image)
	texture = tex
	get_node("/root/ConfigurationNode")._change_and_commit("map","map_type",map)

func prev_map():
	map = (map-1) % 5
	if (map == 0):
		map = 5
	image = Image.new()
	image.load("res://GUI/"+String(map)+".PNG")
	tex = ImageTexture.new()
	tex.create_from_image(image)
	texture = tex
	get_node("/root/ConfigurationNode")._change_and_commit("map","map_type",map)