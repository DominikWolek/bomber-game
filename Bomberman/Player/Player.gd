extends KinematicBody2D

var Name = "nickname"
var hp = 3
var canPlant = 1
var isImmortal = false
var bombDMG = 2
var playerID = "P1"
var dangerList = Array()
var player = int()
export var color = Color(0, 0, 0)
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
		canPlant -= 1
		get_parent().place_bomb(position, Name, bombDMG)
		var timer = Timer.new()
		timer.set_one_shot(true)
		timer.set_wait_time(3) # po 3 sekundach wybucha bomba
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
	
	
	if Input.is_action_pressed(playerID+'_ui_right'):
		velocity.x += 1
	if Input.is_action_pressed(playerID+'_ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed(playerID+'_ui_down'):
		velocity.y += 1
	if Input.is_action_pressed(playerID+'_ui_up'):
		velocity.y -= 1
	
	var temp = ""	
	if (isImmortal):
		temp = "_IMMORTAL"
	if Input.is_action_pressed(playerID+'_ui_right') and !Input.is_action_pressed(playerID+'_ui_left'):
		$Sprite.flip_h = false
		$Sprite.play("run"+temp)
	elif !Input.is_action_pressed(playerID+'_ui_right') and Input.is_action_pressed(playerID+'_ui_left'):
		$Sprite.flip_h = true
		$Sprite.play("run"+temp)
	elif Input.is_action_pressed(playerID+'_ui_down') and Input.is_action_pressed(playerID+'_ui_up'):
		$Sprite.play("idle"+temp)
	elif Input.is_action_pressed(playerID+'_ui_down') and !Input.is_action_pressed(playerID+'_ui_up'):
		$Sprite.play("runDOWN"+temp)
	elif !Input.is_action_pressed(playerID+'_ui_down') and Input.is_action_pressed(playerID+'_ui_up'):
		$Sprite.play("runUP"+temp)
	else: $Sprite.play("idle"+temp)
	
	
	
	velocity = velocity.normalized() * speed
	if Input.is_action_just_pressed(playerID+'_ui_select'): # spacja (bomba)
		plant_bomb()


func _ready():
	if(color != Color(0, 0, 0)):
		modulate = color
	get_parent().connect("explosion", self, "_on_Bomb_explosion", dangerList, player)

func _on_Bomb_explosion(dangerList, player):
	for i in dangerList:
		if ( i == get_parent().world_to_map(position)):
			exploded(player)

func _physics_process(delta):
	get_input()
	move_and_slide(velocity)
	# animacje gracza
	# print(canPlant)