extends KinematicBody2D

var hp = 3 # the number of player's health points, we assume that each player has 3 life points at the beginning of the game
var can_plant = 1 # the amount of bombs a player can set up
var is_immortal = false # true if the player is immortal for a short time
var bomb_dmg = 1 # the bigger the dmg bombs, the bigger the bomb's arms
var player_id # unique player's ID

var danger_list = Array() # the definition of danger_list can
#be found in res://Board/Board.gd
var player = int() # ???

var score # variable that stores player points
var dead # variable indicating whether the player's character is alive
export var color = Color(0, 0, 0) # the color thanks to which we will modulate the appearance of the character

var speed = 200 # player's initial speed

var velocity = Vector2() # vector, by which we can determine the direction of the player's movement

""" 
Method name: set_nickname
Arguments: nickname - name of the character
The function gives a nickname to the character
"""
func set_nickname(nickname):
	name = nickname

"""
Method name: add_bomb
Arguments: brak
Function increases the number of bombs by 1
"""
func add_bomb():
	can_plant += 1

"""
Method name: increase_dmg
Arguments: none
The function increases the explosion arms by 1 (1 in this case means 64x64 square).
"""
func increase_dmg():
	bomb_dmg += 1

"""
Method name: speed_up
Arguments: none
The function increases the speed of the character by 70 units.
"""
func speed_up():
	speed += 70
	pass

"""

Method name: plant_bomb
Arguments: none
The function checks if the player can place a bomb, if so, 
the corresponding function in the parent node is called and 
a timer is added, after which the number of player's bombs will increase by 1.
"""
func plant_bomb():
	if can_plant > 0: # if there is a bomb to plant
		can_plant -= 1
		get_parent().place_bomb(position, player_id) # we call the functions responsible for placing the bomb
		var timer = Timer.new()
		timer.set_one_shot(true)
		timer.set_wait_time(3)
		timer.connect("timeout",self,"add_bomb") # after 3 seconds the add_bomb function for the player will be called
		add_child(timer) 
		timer.start() # adding a timer as a player's child and its start

"""
Method name: not_immortal
Arguments: none
The function removes immortality from the player.
"""
func not_immortal():
	is_immortal = false

"""
Method name: immediate_death
Arguments: none
The function is responsible for the death of the character, playing the right sound
and changing the number of active players on the map
"""
func immediate_death(): # while the map is decreasing
	hp = 0
	dead = true
	Sounds.get_node("Death").position = position
	Sounds.get_node("Death").play()
	get_parent().active_players -= 1
	if(get_parent().active_players == 1):
		get_parent().game_winner()
	queue_free()

"""
Method name: exploded
Arguments: by_who - an opponent who dealt a form of damage
The function is called when the player stands in the place where the bomb 
explodes. If the player is immortal, nothing happens. Otherwise, the corresponding 
sound is played, and points are saved to the player who placed the bomb (if it is not 
the player who has received the damage).
If the character has not died, it becomes immortal for 2 seconds. Otherwise, the 
immediate_death () method is called on the character and the player who placed the 
bomb receives extra points.
"""
func exploded(by_who):
	if is_immortal:
		return
	else:
		Sounds.get_node("Damage").position = position # setting the sound position
		Sounds.get_node("Damage").play()
		if(by_who != player_id): # if the player did not deal damage with the bomb to himself
			get_parent().scores[by_who] += 10
		hp -= 1
		if hp == 0:
			if(by_who != player_id):
				get_parent().scores[by_who] += 10 # extra points for the person who killed the player's character
			immediate_death()
		else:
			is_immortal = true # setting the immortality of the character
			var timer = Timer.new()
			timer.set_one_shot(true)
			timer.set_wait_time(2) # 2 seconds of immortality
			timer.connect("timeout",self,"not_immortal")
			add_child(timer)
			timer.start()

"""
Method name: _check_color
Arguments: none
A function that modulates the player's appearance.
"""
func _check_color():
	if(color != Color(0, 0, 0, 1)):
		modulate = color

"""
Method name: _ready
Arguments: none
The function is called when a node is created. It is used to
connect to signals (that's an internal part of Godot, explaining it here
doesn't make sense)
"""
func _ready():
	dead = false
	score = 0
	get_parent().connect("explosion", self, "_on_bomb_explosion", danger_list, player)
	get_parent().connect("game_winner", self, "winner")

"""
Method name: winner
Arguments: none
A function that if the player's character lives it calls 
the tryToAdd function in the Highscore singleton.
"""
func winner():
	if(!dead):
		Highscore.try_to_add(name, score)

"""
Method name: _on_bomb_explosion
Arguments: danger_list , player
Function is called when a dingla from the bomb is sent
"""
func _on_bomb_explosion(danger_list, player):
	for i in danger_list:
		if ( i == get_parent().world_to_map(position)):
			exploded(player)


"""

Method name: _physics_process
Arguments: delta - time since the previous _physics_process function call
Function performed ~ 60 times per second. Includes updates of the bombs' 
explosion force of the respective players and moving and detecting the bomb 
placement (generally things related to the input)
"""
func _physics_process(delta):
	get_parent().damage_list[player_id] = bomb_dmg 
	character_behaviour()

"""
Method name: movement_direction
Arguments: none
The function responsible for determining the vector that determines 
the direction of the player's movement.
The vector is determined according to the input.
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
Method namme: play_animation
Arguments: none
The function is responsible for loading the appropriate animation depending on
player's movement and whether he is immortal or not.
"""
func play_animation():
	var temp = ""	
	if (is_immortal):
		temp = "_IMMORTAL"
	if Input.is_action_pressed(player_id+'_ui_right') and !Input.is_action_pressed(player_id+'_ui_left'):
		$Sprite.flip_h = false
		$Sprite.play("run"+temp)
	elif !Input.is_action_pressed(player_id+'_ui_right') and Input.is_action_pressed(player_id+'_ui_left'):
		$Sprite.flip_h = true # mirror reflection of animation
		$Sprite.play("run"+temp)
	elif Input.is_action_pressed(player_id+'_ui_down') and Input.is_action_pressed(player_id+'_ui_up'):
		$Sprite.play("idle"+temp)
	elif Input.is_action_pressed(player_id+'_ui_down') and !Input.is_action_pressed(player_id+'_ui_up'):
		$Sprite.play("runDOWN"+temp)
	elif !Input.is_action_pressed(player_id+'_ui_down') and Input.is_action_pressed(player_id+'_ui_up'):
		$Sprite.play("runUP"+temp)
	else: $Sprite.play("idle"+temp)

"""
Method name: character_behaviour
Arguments: none
A function that is responsible for activities related to the player's behavior (including input).
"""
func character_behaviour():
	velocity = movement_direction()
	play_animation()
	velocity = velocity.normalized() * speed # normalized direction of movement multiplied by the speed of movement of the player
	move_and_slide(velocity) # the function responsible for the smooth movement of the characters, the so-called sliding
	if Input.is_action_just_pressed(player_id+'_ui_select'):
		plant_bomb() # if the player has pressed the space button, the corresponding method is called.
