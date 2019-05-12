extends Panel

var gameInfo = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	gameInfo = get_node("/root/ConfigurationNode").gameInfo
	
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
	
func setBot(player,info):
	gameInfo[player].isBot = info
	
func incMap():
	gameInfo.map = (gameInfo.map+1)%5
	_mapLabelChanged()
func decMap():
	gameInfo.map = (gameInfo.map-1)%5
	_mapLabelChanged()
	
func changePlayerName(player,name):
	gameInfo[player].Name = name
	_PlayerChanged(player)
	

func _process(delta):
	pass