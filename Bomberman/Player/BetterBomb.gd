extends Area2D
"""
Nazwa metody: _physic_process
Argumenty: delta - czas jaki minął od poprzedniego wykonania _physic_process
Celem funkcji jest sprawdzenie, czy jakiś gracz wszedł na pole powerupa. Jeśli tak, to powerup znika
a odpowiedni gracz zyskuje bonus (w tym wypadku do wielkości pola rażenia bomby)
"""
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if (body.has_method("increase_dmg")):
			body.increase_dmg()
			queue_free()
			return