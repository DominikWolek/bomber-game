extends StaticBody2D

var in_area = []
var who_planted
var DMG # odnosnie tego bedzie odpowiednio duzy rozprysk bomby w pionie/poziomie

func explode(): #gdyby explode było zrobione na "shape"
	#ze wzgledu na DMG wielkosc rozprysku
	for p in in_area: # dla area o wielkosci DMG
		if (p.has_method("exploded")):
			p.exploded(who_planted)
	get_parent().get_parent().matrix[(position.x-32)/64][(position.y-32)/64] = false
	end()

func end():
	print(position)
	queue_free()

func ready():
	pass