func winnerWinnerChickenDinner():
	var _ScorePair = load("res://Highscore/ScorePair.gd")
	var ScorePair
	var scoresArr: Array
	for i in scores.keys():
		ScorePair = _ScorePair.new()
		ScorePair.nickname = i
		ScorePair.score = scores[i]
		scoresArr.append(ScorePair)
	scoresArr.sort_custom(ScorePair, "sort")
	var endMessage : String
	if(scoresArr[0].score != scoresArr[1].score): #if two players have the same score
	#we don't save it
		endMessage = "Congratulations " + scoresArr[0].nickname + "!\r\nYou've scored "+scoresArr[0].score + " points, " 
		if(Highscore.tryToAdd(scoresArr[0].nickname, scoresArr[0].score)):
			endMessage += "and you've mnaged to get into the highscore list!"
		else:
			endMessage += "but you didn't make it into the highscore list!"
	else:
		endMessage = "We have a tie!\r\n" + scoresArr[0].nickname + " and " + scoresArr[1].nickname + " both have " +scoresArr[0].score + " points." 
	var endLabel = RichTextLabel.new()
	endLabel.add_text(endMessage)
	endLabel.ALIGN_CENTER
	add_child(endLabel)