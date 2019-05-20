extends Node2D

var file_name = "res://high.score"
export var max_size = 10
var table = []
var _ScorePair = load("res://Highscore/ScorePair.gd")

func GetList():
	var HighFile = File.new()
	HighFile.open(file_name, File.READ)
	var scorePair
	table = []

	if(HighFile.get_len() > 0):
		var size = int(HighFile.get_line())
		for i in size:
			scorePair = _ScorePair.new()
			scorePair.nickname = HighFile.get_line()
			scorePair.score = int(HighFile.get_line())
			table.append(scorePair)

	else:
		scorePair = _ScorePair.new()
		scorePair.nickname = "_"
		scorePair.score = 0
		table = []
		table.append(scorePair)
	
	HighFile.close()	
	return table
	
func tryToAdd(nickname, score):
	var HighFile = File.new()
	table = GetList()
	
	if(score > table.back().score):
		#if the score is bigger than the last score on the list, 
		#then we add it to the list
		var scorePair = _ScorePair.new()
		scorePair.nickname = nickname
		scorePair.score = score
		if(table.size() >= max_size):
			#there can by only a certain number of scores
			table.pop_back()
		table.push_back(scorePair)
		table.sort_custom(scorePair, "sort")

		
		HighFile.open(file_name, File.WRITE)
		HighFile.store_line(str(table.size()) + "\r")
		for i in table:
			HighFile.store_line(i.nickname + "\r")
			HighFile.store_line(str(i.score)+ "\r")
		HighFile.close()

		return true
	return false

func reset():
	var HighFile = File.new()
	HighFile.open(file_name, File.WRITE)
	HighFile.close()

func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
