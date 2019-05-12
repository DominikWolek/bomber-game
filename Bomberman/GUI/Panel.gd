extends Panel

var gameInfo = {}
var colors = []

# Called when the node enters the scene tree for the first time.
func _ready():
	gameInfo = get_node("/root/ConfigurationNode").gameInfo
	colors = ["white","black","blue","red","yellow","green","purple","pink","brown","orange"]
	_mapLabelChanged()
	_PlayerChanged("P1")
	_PlayerChanged("P2")
	_PlayerChanged("P3")
	_PlayerChanged("P4")
	
	
func _mapLabelChanged():
	var lab = get_node("mapLabel")
	lab.text = str(gameInfo.map + 1)
	
func _PlayerChanged(player):
	var play = get_node(player+"Settings")
	play.get_node("Name").text = gameInfo[player].Name
	play.get_node("Color").text = colors[gameInfo[player].color]
	play.get_node("isBot").pressed = gameInfo[player].isBot
	var z = play.get_node("isPlaying") 
	if z :
		z.pressed = gameInfo[player].isPlaying
			
	
func setBot(player,info):
	gameInfo[player].isBot = info
	
func setPlaying(player,info):
	gameInfo[player].isPlaying = info

func setNextColor(player):
	changePlayerColor(player,gameInfo[player].color)
	
func incMap():
	gameInfo.map = (gameInfo.map+1)%5
	_mapLabelChanged()
func decMap():
	gameInfo.map = (gameInfo.map-1)%5
	_mapLabelChanged()
	
func changePlayerName(player,name):
	gameInfo[player].Name = name
	_PlayerChanged(player)

func changePlayerColor(player,color):
	gameInfo[player].color = (color+1)%10
	_PlayerChanged(player)

func _process(delta):
	pass