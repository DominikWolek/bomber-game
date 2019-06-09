extends TileMap

var _sparks = load("res://Board/explosionParticle.tscn")
var _bomb = load("res://Board/bomb.tscn")
var _light = load("res://Board/Light2D.tscn")

const bot_can_win = false

var bomb
var light
"""
danger list is an array of positions, that are \"in danger\"
if given position is in danger, it means, that the bomb explosion
affected that position, so the player at that position
should lose one life, or be killed if he has only one left
"""
var danger_list : Array

var resize_count
var resize_time

var damage_list: Dictionary

var active_players
var scores : Dictionary
var player_names: Dictionary

signal explosion( danger_list, Player)
signal game_winner()

"""
Method name: spawn_powerup
Arguments: pos - the position in which the powerup can spawns
That function spawn (with a 50% chance) on of 3 availble powerups
on a given position. Spawned powerups are alos random, every one
of them has a 1/3 chance to spawns
That function returns nothing.
"""

func spawn_powerup(pos):
	randomize()
	if (randi() % 100) < 50: # 50% chance that powerup will fall out
		var type = randi() % 3
		if type == 0:
			var powerup = preload("res://Player//MoreBombs.tscn").instance()
			powerup.position = pos
			get_parent().add_child(powerup)
		elif type == 1:
			var powerup = preload("res://Player//BetterBombs.tscn").instance()
			powerup.position = pos
			get_parent().add_child(powerup)
		elif type == 2:
			var powerup = preload("res://Player//SpeedUP.tscn").instance()
			powerup.position = pos
			get_parent().add_child(powerup)

""" 
Method name: cellv_from_position
Arguments: position - position from which we want to get tile index
The function returns the tile index from the position given as an argument.
"""
func cellv_from_position(position):
	return get_cellv(world_to_map(position))


"""
Method name: spawn_sparks 
Arguments: pos - position
That function spawns particles in given position
That function returns nothing
"""

func spawn_sparks(pos):
	var sparks = _sparks.instance()
	sparks.position = map_to_world(world_to_map(pos)) + Vector2(32, 32)
	add_child(sparks) 
	sparks.set_one_shot(true)
	sparks.set_emitting(true)


"""
Method name: center_explosion 
Arguments: initial_pos - position
That function sets central explosion spot, which include
light, sounds, and initial sparks
That function returns nothing
"""

func center_explosion(initial_pos):
	#here we place the lights effects
	light = _light.instance()
	light.position = map_to_world(world_to_map(initial_pos)) + Vector2(32, 32)
	add_child(light)
	
	#here is the explosion sound
	Sounds.get_node("Explosion").position = initial_pos
	Sounds.get_node("Explosion").play()
	
	#here are the particle effects
	spawn_sparks(initial_pos)

"""
Method name: step
Arguments: i
That function is used to get the direction of explosion
That function returns Vector2, which is the direction
"""

func step(i):
	var step	
	match i:
		0:
			step = Vector2(-64, 0)
		1:
			step = Vector2(0, 64)
		2:
			step = Vector2(64, 0)
		3:
			step = Vector2(0, -64)
	return step


"""
Method name: explodev
Arguments: initial_pos, player
That function is used to make an explosion on the board
it is responsible for the particle effects and lighs effects
and also for calculating which player was in bomb radius,
and informing him about it (sending him a danger list)
danger list definition is placed at the top
v at the end is a naming convention in Godot
it means that the funcion accepts Vector as it's argument
That function returns nothing
"""

func explodev(initial_pos, player):
	var sparks
	var leng
	var pos
	danger_list = Array()
	
	center_explosion(initial_pos)
	danger_list.append(world_to_map(initial_pos))
	
	#we treat explosions as a 4 "row" explosions
	for i in range(4):
		leng = damage_list[player]
		#we reset the starting position every time
		pos = initial_pos
		#first we calculate the tiles on the left, then down, right, up
		pos += step(i)
		#in whle we check if we didn't hit an indestructible tile,
		#and we also check if we can propagate the explosion(leng)
		while get_cellv(world_to_map(pos)) != 0 and leng !=0   :
			if(get_cellv(world_to_map(pos)) == 2):
				#if we hit a destuctible tile, then we destroy that
				#and add one point to the players score
				scores[player] += 1
				set_cellv(world_to_map(pos), 1)
				#also, the explosion int this direction ends
				leng = 1
				spawn_powerup(pos)
			#more particle effects
			spawn_sparks(pos)
			danger_list.append(world_to_map(pos))
			leng -= 1
			pos += step(i)
	#that's self explanatory
	emit_signal("explosion", danger_list, player)

"""
Method name: place_bomb
Arguments: initial_pos, player
That function is used to place a bomb on the board
That function returns a reference to a bomb it created
"""
func place_bomb(initial_pos, player):
	bomb = _bomb.instance()
	bomb.placed_by = player
	bomb.position = map_to_world(world_to_map(initial_pos)) + Vector2(32, 32)
	add_child(bomb)
  return bomb

"""
Method name: resize
Arguments: none
That function is used to resize a board, by calling a
collapse object (to know how the collapse object works, go to 
res://Board/Collapses/Collapse.gd, and res://Board/Collapses/Collapse1.tscn
That function returns nothing
"""

func resize():
	if(resize_count <=5):
		#we only resize the board 5 times
		#collapse is an object that, as the name says
		#collapses the board
		var _collapse = load("res://Board/Collapses/Collapse"+str(resize_count)+".tscn")
		var collapse = _collapse.instance()
		add_child(collapse)
		resize_count += 1

"""
Method name: load_map
Arguments: map_number - int
That function is used to load a tileSet to our Board (which is a tileMap)
That function returns nothing
"""

func load_map(map_number):
	match map_number :
		1:
			set_tileset(load("res://Assets/TileSets/Dirt.tres"))
		2:
			set_tileset(load("res://Assets/TileSets/Wood.tres"))
		3:
			set_tileset(load("res://Assets/TileSets/Water.tres"))
		4:
			set_tileset(load("res://Assets/TileSets/Desert.tres"))
		5:
			set_tileset(load("res://Assets/TileSets/Grass.tres"))
		_: 
			set_tileset(load("res://Assets/TileSets/Dirt.tres"))

"""
Method name: get_player_data
Arguments: game_info - global object that stores game info
That function is used construct an array of playing players
every player in array is loaded as a player or a bot, depending
on the choices made in the previous scene
That function returns an Array of players
"""

func get_player_data(game_info):
	var players = Array()
	players.append(load("res://Player/Player.tscn").instance())
	#here we spawn the players, or bots, depending 
	#on the choices at the prevoius scene
	for i in range (2, 5):
		if game_info["P" + str(i)]["is_playing"] :
			if game_info["P" + str(i)]["is_bot"] :
				players.append(load("res://Bot/Bot.tscn").instance())
			else:
				players.append(load("res://Player/Player.tscn").instance())
	return players

"""
Method name: starting_positions
Arguments: none
That function returns shuffled array of 4 starting positions,
which are the exact coordinates of the map corners
"""

func starting_positions():
	var positions = Array()
	positions.append(Vector2( 64+32, 64+32 ))
	positions.append(Vector2( 64*13+32, 64+32 ))
	positions.append(Vector2( 64+32 , 10*64 - 32 ))
	positions.append(Vector2( 64*13 +32 ,10*64-32 ))
	
	randomize()
	positions.shuffle()
	return positions

"""
Method name: get_color
Arguments: none
That function returns an array of 7 different Color objects,
every object contains different color, as specified int the requirements
"""
func get_color():
	var collor_array = Array()
	collor_array.append(Color(0,0,0,1))
	collor_array.append(Color( 0.8, 0.36, 0.36, 1 ))
	collor_array.append(Color( 0.69, 0.88, 0.9, 1 ))
	collor_array.append(Color( 0.6, 0.98, 0.6, 1 ))
	collor_array.append(Color( 1, 1, 0, 1 ))
	collor_array.append(Color( 0.55, 0.55, 0.55, 1 ))
	collor_array.append(Color( 1, 0.41, 0.71, 1 ))
	return collor_array

"""
Method name: _ready
Arguments: none
That function is derived from the Node2D, it is present in every node
is called once (when the object is created) and it is used to setup
our object properly. Here, it purpose is to set up a map, spawn players
and play music
that's the only comment I'll do on the _ready function in all files
That function returns noting
"""
func _ready():

	#here we prepare the boards for our players
	#we play sounds, if they didn't turn it off
	Sounds.get_node("MainMenu").stop()
	if (ConfigurationNode.get_value("Sounds", "soundSwitch")):
		Sounds.get_node("La Calahorra").play()
	
	var game_info = get_node("/root/ConfigurationNode").game_info
	
	#we load the chosen map
	load_map(game_info["map"]["map_type"])
	var positions = starting_positions()
	var players= get_player_data(game_info)
	
	var color_map = get_color()
	var j = 0
	var player_count = 0
	for i in players :
		#here we shuffle the positions,
		#modulate the colours, assigns names
		if i:
			player_count  += 1
			add_child(i)
			i.player_id = "P"+str(j+1)
			scores[i.player_id] = 0
			i.name = get_node("/root/ConfigurationNode").get_value("P"+str(j+1),"name")
			player_names[i.player_id] = i.name
			i.position=positions[j]
			var color = get_node("/root/ConfigurationNode").get_value("P"+str(j+1),"color")
			i.color = color_map[color]
			i._check_color()
			i.score = 0
		j+=1
	
	active_players = player_count
	resize_count = 1
	resize_time = Timer.new()
	resize_time.start(45)
	add_child(resize_time)
	resize_time.connect("timeout", self, "_on_resize_time_timeout")


"""
Method name: game_winner
Arguments: none
That function is used to end the game. it figures out which player
(or bot, if that option is active) is supposed to win, or if there was 
a tie. It also tries to write the player into the highscore list
It also spawns an EndGame object
That function returns noting
"""

func game_winner():
	#here we rank our players
	var game_info = get_node("/root/ConfigurationNode").game_info
	
	var _score_pair = load("res://Highscore/ScorePair.gd")
	var score_pair
	var scores_arr: Array
	for i in scores.keys():
		score_pair = _score_pair.new()
		if((bot_can_win == false) and (game_info[str(i)]["is_bot"] )):
			score_pair.nickname = "BOT"
			score_pair.score = -1
		else:
			score_pair.nickname = i
			score_pair.score = scores[i]
		scores_arr.append(score_pair)
	
	scores_arr.sort_custom(score_pair, "sort")

	var end_message : String
	if(scores_arr[0].score != scores_arr[1].score): #if two players have the same score
	#we don't save it
		end_message = "Congratulations " + player_names[scores_arr[0].nickname] + "!\r\nYou've scored "+str(scores_arr[0].score) + " points, " 
		if(Highscore.try_to_add(player_names[scores_arr[0].nickname], scores_arr[0].score)):
			end_message += "and you've managed to get into the highscore list!"
		else:
			end_message += "but you didn't make it into the highscore list!"
	else:
		end_message = "We have a tie!\r\n" + player_names[scores_arr[0].nickname] + " and " + player_names[scores_arr[1].nickname] + " both have " +str(scores_arr[0].score) + " points." 
	var _end_label = load("res://Board/Endgame.tscn")
	var end_label = _end_label.instance()
	end_label.add(end_message)
	add_child(end_label)
	
	
"""
Method name: _on_resize_time_timeout
Arguments: none
That function is called when the resizeTimer will send out a 
timeout signal
That function returns noting
"""

func _on_resize_time_timeout():
	resize()