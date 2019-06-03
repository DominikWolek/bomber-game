extends KinematicBody2D

var hp = 3
var can_plant = 1
var is_immortal = false
var bomb_dmg = 1
var player_id
var danger_list = Array()
var player = int()

var score
var dead
export var color = Color(0, 0, 0)

export (int) var speed = 200

var velocity = Vector2()

func set_nickname(nickname):
	name = nickname
func add_bomb():
	can_plant += 1
func increase_dmg():
	bomb_dmg += 1
func speed_up():
	speed += 70

func plant_bomb():
	if can_plant > 0: # jeśli jest jakas bomba do podłożenia
		can_plant -= 1
		get_parent().place_bomb(position, player_id)
		var timer = Timer.new()
		timer.set_one_shot(true)
		timer.set_wait_time(3) # po 3 sekundach wybucha bomba
		timer.connect("timeout",self,"add_bomb")
		add_child(timer)
		timer.start()

func not_immortal():
	is_immortal = false

func immediate_death(): # przy zmniejszaniu sie mapy
	hp = 0
	dead = true
	Sounds.get_node("Death").position = position
	Sounds.get_node("Death").play()
	get_parent().activePlayers -= 1
	if(get_parent().activePlayers == 1):
		get_parent().winnerWinnerChickenDinner()
	queue_free()

func exploded(by_who):
	if is_immortal:
		return
	else:
		is_immortal = true
		Sounds.get_node("Damage").position = position
		Sounds.get_node("Damage").play()
		if(by_who != player_id):
			get_parent().scores[by_who] += 10
		hp -= 1
		if hp == 0:
			if(by_who != player_id):
				get_parent().scores[by_who] += 10
			immediate_death()
		else:
			var timer = Timer.new()
			timer.set_one_shot(true)
			timer.set_wait_time(2) #2 sekundowa niesmiertelnosc
			timer.connect("timeout",self,"not_immortal")
			add_child(timer)
			timer.start()

func _check_color():
	if(color != Color(0, 0, 0, 1)):
		modulate = color

func _ready():
	dead = false
	score = 0
	get_parent().connect("explosion", self, "_on_bomb_explosion", danger_list, player)
	get_parent().connect("winnerWinnerChickenDinner", self, "winner")

func winner():
	if(!dead):
		Highscore.tryToAdd(name, score)

func _on_bomb_explosion(danger_list, player):
	for i in danger_list:
		if ( i == get_parent().world_to_map(position)):
			exploded(player)




# do zmiany



var position_to_achieve = position
var moving = false
var direction = -1
var stop = true

func _direction(position, prev_dir):
	var num = 0
	var array = [false,false,false,false]
	var right = 0
	var left = 0
	var up = 0
	var down = 0
	if (get_parent().get_cellv(get_parent().world_to_map(position+Vector2(64,0)))!=2 and get_parent().get_cellv(get_parent().world_to_map(position+Vector2(64,0)))!=0): #jesli nie jest to skrzynka ani niezniszczalny obiekt (po prawej)
		array[num] = true
		if (prev_dir == 1):
			right = 2
		else: right = 10
	num += 1
	if (get_parent().get_cellv(get_parent().world_to_map(position+Vector2(-64,0)))!=2 and get_parent().get_cellv(get_parent().world_to_map(position+Vector2(-64,0)))!=0): #jesli nie jest to skrzynka ani niezniszczalny obiekt (po lewej)
		array[num] = true
		if (prev_dir == 0):
			left = 2
		else: left = 10
	left += right
	num += 1
	if (get_parent().get_cellv(get_parent().world_to_map(position+Vector2(0,-64)))!=2 and get_parent().get_cellv(get_parent().world_to_map(position+Vector2(0,-64)))!=0): #jesli nie jest to skrzynka ani niezniszczalny obiekt (powyzej)
		array[num] = true
		if (prev_dir == 3):
			up = 2
		else: up = 10
	up += left
	num += 1
	if (get_parent().get_cellv(get_parent().world_to_map(position+Vector2(0,64)))!=2 and get_parent().get_cellv(get_parent().world_to_map(position+Vector2(0,64)))!=0): #jesli nie jest to skrzynka ani niezniszczalny obiekt (ponizej)
		array[num] = true
		if (prev_dir == 2):
			down = 2
		else: down = 10
	down += up
	randomize()
	var random_number = randi()% down
	if (random_number < right):
		return 0
	elif (random_number < left):
		return 1
	elif (random_number < up):
		return 2
	else:
		return 3

func possiblePlant(position):
	if can_plant>0:
		var index
		for i in range(bomb_dmg):
			index = get_parent().get_cellv(get_parent().world_to_map(position+(i+1)*Vector2(64,0)))
			if (index == 2):
				return true
			elif (index == 0):
				break
		for i in range(bomb_dmg):
			index = get_parent().get_cellv(get_parent().world_to_map(position+(i+1)*Vector2(-64,0)))
			if (index == 2):
				return true
			elif (index == 0):
				break
		for i in range(bomb_dmg):
			index = get_parent().get_cellv(get_parent().world_to_map(position+(i+1)*Vector2(0,-64)))
			if (index == 2):
				return true
			elif (index == 0):
				break
		for i in range(bomb_dmg):
			index = get_parent().get_cellv(get_parent().world_to_map(position+(i+1)*Vector2(0,64)))
			if (index == 2):
				return true
			elif (index == 0):
				break
	return false

func get_input():
	if moving == false:
		if (possiblePlant(position)):
			plant_bomb()
			if (direction == 0):
				direction = 1
			elif (direction == 1):
				direction = 0
			elif (direction == 2):
				direction = 3
			elif (direction == 3): 
				direction = 2
			else: direction = _direction(position, direction)
		else: 
			direction = _direction(position, direction)
		moving = true
		if (direction == 0):
			velocity.x += 1
			position_to_achieve = position + Vector2(64,0)
		elif (direction == 1):
			velocity.x -= 1
			position_to_achieve = position + Vector2(-64,0)
		elif (direction == 2):
			velocity.y -= 1
			position_to_achieve = position + Vector2(0,-64)
		else: 
			velocity.y += 1
			position_to_achieve = position + Vector2(0,64)
		velocity = velocity.normalized() * speed
		
		var temp = ""	
		if (is_immortal):
			temp = "_IMMORTAL"
		if direction == 0:
			$Sprite.flip_h = false
			$Sprite.play("run"+temp)
		elif direction == 1:
			$Sprite.flip_h = true
			$Sprite.play("run"+temp)
		#elif Input.is_action_pressed('ui_down') and Input.is_action_pressed('ui_up'):
		#	$Sprite.play("idle"+temp)
		elif direction == 3:
			$Sprite.play("runDOWN"+temp)
		elif direction == 2:
			$Sprite.play("runUP"+temp)
		else: $Sprite.play("idle"+temp)

func _physics_process(delta):
	get_parent().damageList[player_id] = bomb_dmg
	get_input()
	move_and_slide(velocity)
	if (direction == 0):
		if (position.x > position_to_achieve.x):
			position.x = position_to_achieve.x
			moving = false
			velocity = Vector2()
	if (direction == 1):
		if (position.x < position_to_achieve.x):
			position.x = position_to_achieve.x
			moving = false
			velocity = Vector2()
	if (direction == 2):
		if (position.y < position_to_achieve.y):
			position.y = position_to_achieve.y
			moving = false
			velocity = Vector2()
	if (direction == 3):
		if (position.y > position_to_achieve.y):
			position.y = position_to_achieve.y
			moving = false
			velocity = Vector2()