extends KinematicBody2D

var Name = "nickname"
var hp = 3
var canPlant = 1
var isImmortal = false
var bombDMG = 1
var playerID = "P1"
var dangerList = Array()
var player = int()

var score
var dead
export var colour = Color(0, 0, 0)

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
		get_parent().place_bomb(position, playerID)
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
	dead = true
	Sounds.get_node("Death").position = position
	Sounds.get_node("Death").play()
	get_parent().activePlayers -= 1
	get_parent().winnerWinnerChickenDinner()
	queue_free()

func exploded(by_who):
	if isImmortal:
		return
	else:
		isImmortal = true
		Sounds.get_node("Damage").position = position
		Sounds.get_node("Damage").play()
		# ewentualny zapis statystyk dla gracza by_who
		hp -= 1
		if hp == 0:
			immediateDeath()
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


func _check_colour():
	if(colour != Color(0, 0, 0, 1)):
		modulate = colour

func _ready():
	dead = false
	score = 0
	get_parent().connect("explosion", self, "_on_Bomb_explosion", dangerList, player)
	get_parent().connect("winnerWinnerChickenDinner", self, "winner")


func winner():
	if(!dead):
		Highscore.tryToAdd(name, score)

func _on_Bomb_explosion(dangerList, player):
	for i in dangerList:
		if ( i == get_parent().world_to_map(position)):
			exploded(player)

func _physics_process(delta):
	get_parent().damageList[playerID] = bombDMG
	get_input()
	move_and_slide(velocity)
	# animacje gracza
	# print(canPlant)