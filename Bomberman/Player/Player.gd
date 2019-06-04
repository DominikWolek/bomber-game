extends KinematicBody2D

<<<<<<< HEAD
var Name = "nickname"
var hp = 3
var canPlant = 1
var isImmortal = false
var bombDMG = 1
var playerID = "P1"
var danger_list = Array()
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
=======
var hp = 3 # ilość punktów życia gracza, zakładamy że każdy gracz posiada 3 punkty życia na początku rozgrywki
var can_plant = 1 # ilość bomb jakie może postawić gracz
var is_immortal = false # true jeśli gracz jest przez krótki czas nieśmiertelny
var bomb_dmg = 1 # im większy bomb dmg tym większe ramiona wybuchu bomby
var player_id # unikalne ID gracza

var danger_list = Array() # ???
var player = int() # ???

var score # zmienna przechowująca punkty gracza
var dead # zmienna wskazująca na to, czy postać gracza żyje
export var color = Color(0, 0, 0) # kolor dzięki któremu będziemy modulować wygląd postaci

export (int) var speed = 200 # początkowa prędkość gracza

var velocity = Vector2() # wektor, za pomocą którego ustalamy kierunek ruchu gracza

""" 
Nazwa metody: set_nickname
Argumenty: nickname - nazwa postaci
Funkcja przypisuje postaci nazwę podaną jako argument nickname.
"""
func set_nickname(nickname):
	name = nickname

"""
Nazwa metody: add_bomb
Argumenty: brak
Funkcja zwiększa liczbę bomb gracza o 1.
"""
func add_bomb():
	can_plant += 1

"""
Nazwa metody: increase_dmg
Argumenty: brak
Funkcja zwiększa ramiona wymuchu o 1 (1 w tym wypadku oznacza kwadrat o wymiarach 64x64).
"""
func increase_dmg():
	bomb_dmg += 1

"""
Nazwa metody: speed_up
Argumenty: brak
Funkcja zwiększa prędkość postaci o 70 jednostek.
"""
func speed_up():
>>>>>>> zmiany_brozek
	speed += 70

"""
Nazwa metody: plant_bomb
Argumenty: brak
Funkcja sprawdza, czy gracz może podłożyć bombę, jeśli tak to wywoływana jest odpowiednia funkcja 
w węźle-rodzicu oraz dodawany jest timer, po którego upływie ilość bomb gracza zwiększy się o 1.
"""
func plant_bomb():
	if can_plant > 0: # jeśli jest jakas bomba do podłożenia
		can_plant -= 1
		get_parent().place_bomb(position, player_id) # wywołujemy funkcje odpowiedzialną za postawienie bomby
		var timer = Timer.new()
		timer.set_one_shot(true)
		timer.set_wait_time(3)
		timer.connect("timeout",self,"add_bomb") # po 3 sekundach wywołana zostanie funkcja add_bomb dla gracza
		add_child(timer) 
		timer.start() #dodanie timera jako dziecka gracza i jego start

"""
Nazwa metody: not_immortal
Argumenty: brak
Funkcja zdejmuje nieśmiertelność z gracza.
"""
func not_immortal():
	is_immortal = false

"""
Nazwa metody: immediate_death
Argumenty: brak
Funkcja odpowiedzialna jest za śmierć postaci, odtworzenie odpowiedniego dźwięku
oraz zmianę ilości aktywnych graczy na mapie
"""
func immediate_death(): # przy zmniejszaniu sie mapy
	hp = 0
	dead = true
<<<<<<< HEAD
	Sounds.get_node("Death").position = position
	Sounds.get_node("Death").play()
	get_parent().active_players -= 1
	if(get_parent().active_players == 1):
		get_parent().winnerWinnerChickenDinner()
=======
	Sounds.get_node("Death").position = position 
	Sounds.get_node("Death").play() # ustalenie pozycji dźwięku (jest on 2 wymiarowy) i odtworzenie go
	get_parent().activePlayers -= 1 # zmniejszenie ilości aktywnych graczy
	if(get_parent().activePlayers == 1):
		get_parent().winnerWinnerChickenDinner() # jeśli został tylko 1 żywy gracz, to należy ogłosić go zwycięzcą
>>>>>>> zmiany_brozek
	queue_free()

"""
Nazwa metody: expoded
Argumenty: by_who - przeciwnik, który zadał postaci obrażenia
Funkcja wywoływana, gdy gracz stanie w miejscu wybuchu bomby. Jeśli gracz jest nieśmiertelny,
to nic się nie dzieje. W przeciwnym wypadku odtwarzany jest odpowiedni dźwięk, i zapisywane są
punkty graczowi, który postawił bombę (jeśli nie jest nim gracz, który otrzymał obrażenia).
Jeśli postać nie umarła, to staje się nieśmiertelna na 2 sekundy. W przeciwnym wypadku na postaci 
wywoływana jest metoda immediate_death(), a gracz który postawił bombę otrzymuje dodatkowe punkty.
"""
func exploded(by_who):
	if is_immortal:
		return
	else:
		Sounds.get_node("Damage").position = position
		Sounds.get_node("Damage").play()
		if(by_who != player_id):
			get_parent().scores[by_who] += 10
		hp -= 1
		if hp == 0:
			if(by_who != player_id):
				get_parent().scores[by_who] += 10 # dodatkowe punkty
			immediate_death()
		else:
			is_immortal = true
			var timer = Timer.new()
			timer.set_one_shot(true)
			timer.set_wait_time(2) # 2 sekundowa nieśmiertelność
			timer.connect("timeout",self,"not_immortal")
			add_child(timer)
			timer.start()

"""
Nazwa metody: _check_color
Argumenty: brak
Funkcja, która moduluje wygląd gracza.
"""
func _check_color():
	if(color != Color(0, 0, 0, 1)):
		modulate = color

"""
Nazwa metody: _ready
Argumenty: brak
Funkcja wywoływana jest, gry powstaje obiekt danej klasy. 
???
"""
func _ready():
	dead = false
	score = 0
	get_parent().connect("explosion", self, "_on_bomb_explosion", danger_list, player)
	get_parent().connect("winnerWinnerChickenDinner", self, "winner")

"""
Nazwa metody: winner
Argumenty: brak
Funkcja, która jeśli postać gracza żyje to wywołuje funkcję tryToAdd w singletonie Highscore.
"""
func winner():
	if(!dead):
		Highscore.tryToAdd(name, score)

"""
Nazwa metody: 
Argumenty: brak
Funkcja 
???
"""
func _on_bomb_explosion(danger_list, player):
	for i in danger_list:
		if ( i == get_parent().world_to_map(position)):
			exploded(player)




"""
Nazwa metody: _physics_process
Argumenty: delta - czas od poprzedniego wywołania funkcji _physics_process
Funkcja wykonywana ~60 razy na sekundę. Obejmuje aktualizacje siły wybuchy bomby
odpowiednich graczy oraz poruszanie i wykrywanie podkładania bomby (ogołnie
rzeczy związane z inputem)
"""
func _physics_process(delta):
	get_parent().damageList[player_id] = bomb_dmg
	get_input()
	move_and_slide(velocity) # funkcja odpowiedzialna za płynne poruszanie się postaci, tzw. sliding

"""
Nazwa metody: movement_direction
Argumenty: brak
Funkcja odpowiedzialna za ustalenie wektora, który wyznacza kierunek ruchu gracza.
Wektor wyznaczany jest zgodnie z inputem.
"""
func movement_direction():
	velocity = Vector2()
	if Input.is_action_pressed(player_id+'_ui_right'):
		velocity.x += 1
	if Input.is_action_pressed(player_id+'_ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed(player_id+'_ui_down'):
		velocity.y += 1
	if Input.is_action_pressed(player_id+'_ui_up'):
		velocity.y -= 1
	return velocity

"""
Nazwa metody: play_animation
Argumenty: brak
Funkcja odpowiedzialna jest za ładowanie odpowiedniej animacji w zależności od
ruchu gracza oraz tego czy jest on nieśmiertelny, czy też nie.
"""
func play_animation():
	var temp = ""	
	if (is_immortal):
		temp = "_IMMORTAL"
	if Input.is_action_pressed(player_id+'_ui_right') and !Input.is_action_pressed(player_id+'_ui_left'):
		$Sprite.flip_h = false
		$Sprite.play("run"+temp)
	elif !Input.is_action_pressed(player_id+'_ui_right') and Input.is_action_pressed(player_id+'_ui_left'):
		$Sprite.flip_h = true
		$Sprite.play("run"+temp)
	elif Input.is_action_pressed(player_id+'_ui_down') and Input.is_action_pressed(player_id+'_ui_up'):
		$Sprite.play("idle"+temp)
	elif Input.is_action_pressed(player_id+'_ui_down') and !Input.is_action_pressed(player_id+'_ui_up'):
		$Sprite.play("runDOWN"+temp)
	elif !Input.is_action_pressed(player_id+'_ui_down') and Input.is_action_pressed(player_id+'_ui_up'):
		$Sprite.play("runUP"+temp)
	else: $Sprite.play("idle"+temp)
<<<<<<< HEAD
	
	
	
	velocity = velocity.normalized() * speed
	if Input.is_action_just_pressed(playerID+'_ui_select'): # spacja (bomba)
		plant_bomb()


func _check_colour():
	if(colour != Color(0, 0, 0, 1)):
		modulate = colour

func _ready():
	dead = false
	score = 0
	get_parent().connect("explosion", self, "_on_Bomb_explosion", danger_list, player)
	get_parent().connect("winnerWinnerChickenDinner", self, "winner")


func winner():
	if(!dead):
		Highscore.try_to_add(name, score)

func _on_Bomb_explosion(danger_list, player):
	for i in danger_list:
		if ( i == get_parent().world_to_map(position)):
			exploded(player)

func _physics_process(delta):
	get_parent().damage_list[playerID] = bombDMG
	get_input()
	move_and_slide(velocity)
	# animacje gracza
	# print(canPlant)
=======

"""
Nazwa metody: get_input
Argumenty: brak
Funkcja która jest odpowiedzialna za działania związane z inputem (sterowaniem). 
"""
func get_input():
	velocity = movement_direction()
	play_animation()
	velocity = velocity.normalized() * speed # znormalizowany kierunek ruchu pomnożony przez prędkość poruszania się gracza
	if Input.is_action_just_pressed(player_id+'_ui_select'):
		plant_bomb() # jeśli gracz wcisnął przycisk spacji, to wywoływana jest odpowiednia metoda.
>>>>>>> zmiany_brozek
