extends StaticBody2D

var in_area = []
var who_planted
var DMG # odnosnie tego bedzie odpowiednio duzy rozprysk bomby w pionie/poziomie
var timer = null

func explode():
	for p in in_area:
		if (p.has_method("exploded")):
			p.exploded(who_planted)
	end()
	
func end():
	print("XD")
	queue_free()

func ready():
	
	pass