extends Area2D
"""
Nazwa metody: _physic_process
Argumenty: delta - czas jaki minął od poprzedniego wykonania _physic_process
Celem funkcji jest sprawdzenie, czy jakiś gracz wszedł na pole powerupa. Jeśli tak, to powerup znika
a odpowiedni gracz zyskuje bonus (w tym wypadku do ilości posiadanych bomb)
"""
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if (body.has_method("add_bomb")):
			body.add_bomb()
			queue_free()
			return
