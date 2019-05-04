extends KinematicBody2D

var Name = "nickname"
var hp = 3
var canPlant = 1
var isImmortal = false
var bombDMG = 1

export (int) var speed = 200

var velocity = Vector2()

func setNickname(nickname):
	Name = nickname
func addBomb():
	canPlant += 1
func increaseDMG():
	bombDMG += 1
func speedUP():
	speed += 70

func plant_bomb():
	if canPlant > 0: # jeśli jest jakas bomba do podłożenia
	
		#if get_cellv(position,BOMB_NUMBER)==BOMB_NUMBER: #BOMB_NUMBER DO USTALENIA, jeśli na płytce jest postawiona bomba
		#	return # nie można postawić bomby
		#else: set_cellv(position,BOMB_NUMBER)
		
		canPlant -= 1
		var bomb = preload("res://Bomb.tscn").instance()
		bomb.who_planted = Name
		bomb.DMG = bombDMG
		
		bomb.position.x = position.x #wrzucenie odpowiedniej pozycji bomby
		bomb.position.y = position.y #wrzucenie odpowiedniej pozycji bomby
		get_parent().add_child(bomb)
		var timer = Timer.new()
		timer.set_one_shot(true)
		timer.set_wait_time(3) # po 3 sekundach wybucha bomba
		timer.connect("timeout",bomb,"explode")
		timer.connect("timeout",self,"addBomb")
		add_child(timer)
		timer.start()

func notImmortal():
	isImmortal = false

func immediateDeath(): # przy zmniejszaniu sie mapy
	hp = 0
	queue_free()

func exploded(by_who):
	if isImmortal:
		return
	else:
		isImmortal = true
		# ewentualny zapis statystyk dla gracza by_who
		hp -= 1
		if hp == 0:
			# ewentualny zapis statystyk (jakichs)
			queue_free()
		else:
			var timer = Timer.new()
			timer.set_one_shot(true)
			timer.set_wait_time(2) #2 sekundowa niesmiertelnosc
			timer.connect("timeout",self,"notImmortal")
			add_child(timer)
			timer.start()

func get_input():
	velocity = Vector2()
	
	
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
		
	if isImmortal==false:
		if Input.is_action_pressed('ui_right') and !Input.is_action_pressed('ui_left'):
			$Sprite.flip_h = false
			$Sprite.play("run")
		elif !Input.is_action_pressed('ui_right') and Input.is_action_pressed('ui_left'):
			$Sprite.flip_h = true
			$Sprite.play("run")
		elif Input.is_action_pressed('ui_down') and Input.is_action_pressed('ui_up'):
			$Sprite.play("idle")
		elif Input.is_action_pressed('ui_down') and !Input.is_action_pressed('ui_up'):
			$Sprite.play("runDOWN")
		elif !Input.is_action_pressed('ui_down') and Input.is_action_pressed('ui_up'):
			$Sprite.play("runUP")
		else: $Sprite.play("idle")
	elif isImmortal==true:
		if Input.is_action_pressed('ui_right') and !Input.is_action_pressed('ui_left'):
			$Sprite.flip_h = false
			$Sprite.play("run_IMMORTAL")
		elif !Input.is_action_pressed('ui_right') and Input.is_action_pressed('ui_left'):
			$Sprite.flip_h = true
			$Sprite.play("run_IMMORTAL")
		elif Input.is_action_pressed('ui_down') and Input.is_action_pressed('ui_up'):
			$Sprite.play("idle_IMMORTAL")
		elif Input.is_action_pressed('ui_down') and !Input.is_action_pressed('ui_up'):
			$Sprite.play("runDOWN_IMMORTAL")
		elif !Input.is_action_pressed('ui_down') and Input.is_action_pressed('ui_up'):
			$Sprite.play("runUP_IMMORTAL")
		else: $Sprite.play("idle_IMMORTAL")
	
	
	velocity = velocity.normalized() * speed
	if Input.is_action_pressed('ui_select'): # spacja (bomba)
		plant_bomb()

func _physics_process(delta):
	get_input()
	move_and_slide(velocity)
	# animacje gracza
	# print(canPlant)