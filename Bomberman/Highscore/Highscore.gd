extends Node2D

var file_name = "res://high.score"
export var max_size = 10
var _score_pair = load("res://Highscore/ScorePair.gd")

func get_list():
	var table = []
	var high_score_file = File.new()
	high_score_file.open(file_name, File.READ)
	var score_pair
	#table = []

	if(high_score_file.get_len() > 0):
		var size = int(high_score_file.get_line())
		for i in size:
			score_pair = _score_pair.new()
			score_pair.nickname = high_score_file.get_line()
			score_pair.score = int(high_score_file.get_line())
			table.append(score_pair)
	
	high_score_file.close()
	return table
	
func try_to_add(nickname, score):
	var high_score_file = File.new()
	var table = get_list()
	var score_pair = _score_pair.new()
	score_pair.nickname = nickname
	score_pair.score = score
	if(table.size() == 0):
		table.push_back(score_pair)
		high_score_file.open(file_name, File.WRITE)
		high_score_file.store_line(str(table.size()) + "\r")
		high_score_file.store_line(table[0].nickname + "\r")
		high_score_file.store_line(str(table[0].score)+ "\r")
		high_score_file.close()
		return true
	
	
	if((score > table.back().score) or (table.size() < max_size)):
		#if the score is bigger than the last score on the list, 
		#then we add it to the list

		if(table.size() >= max_size):
			#there can by only a certain number of scores
			table.pop_back()
		table.push_back(score_pair)
		table.sort_custom(score_pair, "sort")

		
		high_score_file.open(file_name, File.WRITE)
		high_score_file.store_line(str(table.size()) + "\r")
		for i in table:
			high_score_file.store_line(i.nickname + "\r")
			high_score_file.store_line(str(i.score)+ "\r")
		high_score_file.close()

		return true
	return false

func reset():
	var high_score_file = File.new()
	high_score_file.open(file_name, File.WRITE)
	high_score_file.close()

func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
