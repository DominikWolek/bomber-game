extends Panel

var game_info = {}
var colors = []

# Called when the node enters the scene tree for the first time.
func _ready():
	game_info = get_node("/root/ConfigurationNode").game_info
	colors = ["Basic","Red","Blue","Green","Yellow","Grey","Pink"]
	player_changed("P1")
	player_changed("P2")
	player_changed("P3")
	player_changed("P4")

func player_changed(player):
	var play = get_node(player+"Settings")
	play.get_node("Name").text = game_info[player]["name"]
	play.get_node("Color").text = colors[game_info[player]["color"]]
	play.get_node("isBot").pressed = game_info[player]["is_bot"]
	if play.has_node("isPlaying"):
		play.get_node("isPlaying").pressed = game_info[player]["is_playing"]

func set_bot(player,info):
	get_node("/root/ConfigurationNode").change_and_commit(player,"is_bot",info)

func set_playing(player,info):
	get_node("/root/ConfigurationNode").change_and_commit(player,"is_playing",info)

func set_next_color(player):
	change_player_color(player,game_info[player]["color"])

func change_player_name(player,name):
	get_node("/root/ConfigurationNode").change_and_commit(player,"name", name)
	player_changed(player)

func change_player_color(player,color):
	get_node("/root/ConfigurationNode").change_and_commit(player,"color",(color+1) % 7)
	player_changed(player)

func _process(delta):
	pass