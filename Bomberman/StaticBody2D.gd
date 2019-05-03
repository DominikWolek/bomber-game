extends Area2D
var already_exploded = false

func exploded(by_who):
	
	#dodanie pkt za zniszczenie obiektu
	if already_exploded == true:
		return
	already_exploded = true
	var timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(1.5) #1.5 sekund trwa promien  sekundowa niesmiertelnosc
	timer.connect("timeout",self,"die")
	add_child(timer)
	timer.start()
	
func die():
	randomize()
	if (randi() % 100) < 50: #50% szans ze wypadnie powerup
		var type = randi() % 3
		if type == 0:
			var powerup = preload("res://MoreBombs.tscn").instance()
			powerup.position = position
			get_parent().add_child(powerup)
		elif type == 1:
			var powerup = preload("res://BetterBombs.tscn").instance()
			powerup.position = position
			get_parent().add_child(powerup)
		elif type == 2:
			var powerup = preload("res://SpeedUP.tscn").instance()
			powerup.position = position
			get_parent().add_child(powerup)
	queue_free()

var died = false

func _physics_process(delta):
	if died == false:
		var bodies = get_overlapping_bodies()
		for body in bodies:
			if body.has_method("exploded"):
				died = true
				exploded(body.Name)