extends StaticBody2D

var in_area = []
var who_planted
var DMG # odnosnie tego bedzie odpowiednio duzy rozprysk bomby w pionie/poziomie

func explode(): #gdyby explode było zrobione na "shape"
	#ze wzgledu na DMG wielkosc rozprysku
	for p in in_area: # dla area o wielkosci DMG
		if (p.has_method("exploded")):
			p.exploded(who_planted)
	end()

func end():
	print("b00m")
	queue_free()

func ready():
	pass