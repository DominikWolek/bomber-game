extends TileMap

var _sparks = load("res://Board/explosionParticle.tscn")
var _bomb = load("res://Board/bomb.tscn")
var _light = load("res://Board/Light2D.tscn")


var hitmark
var bomb
var light
var danger_list

var resize_count
var resize_time

var damage_list: Dictionary

var active_players
var scores : Dictionary
var player_names: Dictionary

signal explosion( danger_list, Player)
signal winnerWinnerChickenDinner()

#pos - position. I dont think that argument position on a function
#that's named spawn_something needs an explination
func spawn_powerup(pos):
	randomize()
	if (randi() % 100) < 50: #50% szans ze wypadnie powerup
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


#function explode is used to literally make an explosion on the board
#it is responsible for the particle effects and lighs effects
#and also for calculating which player was in bomb radius,
#and informing him about it
#v at the end is a naming convention in Godot
#it means that the funcion accepts Vector as it's argument
func cellv_from_position(position):
	return get_cellv(world_to_map(position))

func explodev(initial_pos, player):
	var sparks
	var leng
	var pos
	var step
	danger_list = Array()
	
	#here we place the lights effects
	light = _light.instance()
	light.position = map_to_world(world_to_map(initial_pos)) + Vector2(32, 32)
	add_child(light)
	Sounds.get_node("Explosion").position = initial_pos
	Sounds.get_node("Explosion").play()
	
	#here are the particle effects
	sparks = _sparks.instance()
	sparks.position = map_to_world(world_to_map(initial_pos)) + Vector2(32, 32)
	danger_list.append(world_to_map(initial_pos))
	add_child(sparks) 
	sparks.set_one_shot(true)
	sparks.set_emitting(true)
	#we treat explosions as a 4 "row" explosions
	for i in range(4):
		leng = damage_list[player]
		#we reset the starting position every time
		pos = initial_pos
		#first we calculate the tiles on the left, then down, right, up
		if (i == 0):
			step = Vector2(-64, 0)
		elif (i == 1):
			step = Vector2(0, 64)
		elif (i == 2):
			step = Vector2(64, 0)
		elif (i == 3):
			step = Vector2(0, -64)
		pos += step
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
			sparks = _sparks.instance()
			sparks.position = map_to_world(world_to_map(pos)) + Vector2(32, 32)
			danger_list.append(world_to_map(pos))
			add_child(sparks) 
			sparks.set_one_shot(true)
			sparks.set_emitting(true)
			leng -= 1
			pos += step
	#that's self explanatory
	emit_signal("explosion", danger_list, player)

#I tried to write a delf commentating code
#and i really think i succeeded here
func place_bomb(initial_pos, player):
	bomb = _bomb.instance()
	bomb.placed_by = player
	bomb.position = map_to_world(world_to_map(initial_pos)) + Vector2(32, 32)
	add_child(bomb)
		
		
func resize():
	if(resize_count <=5):
		#we only resize the board 5 times
		#collapse is an object that, as the name says
		#collapses the board
		var _collapse = load("res://Board/Collapses/Collapse"+str(resize_count)+".tscn")
		var collapse = _collapse.instance()
		add_child(collapse)
		resize_count += 1
		


func shuffle_list(list):
	var shuffled_list = []
	randomize()
	var index_list = range(list.size())
	for i in range(list.size()):
		var x = randi()%index_list.size()
		shuffled_list.append(list[index_list[x]])
		index_list.remove(x)
	return shuffled_list
	
	
func _ready():

	#here we prepare the boards for our players
	#we play sounds, if they didn't turn it off
	Sounds.get_node("MainMenu").stop()
	if (ConfigurationNode.get_value("Sounds", "soundSwitch")):
		Sounds.get_node("GamePlay").play()
	
	#we load the chosen map
	var game_info = get_node("/root/ConfigurationNode").game_info
	if(game_info["map"]["map_type"] == 1):
		set_tileset(load("res://Assets/TileSets/Dirt.tres"))
	elif(game_info["map"]["map_type"] == 2):
		set_tileset(load("res://Assets/TileSets/Wood.tres"))
	elif(game_info["map"]["map_type"] == 3):
		set_tileset(load("res://Assets/TileSets/Water.tres"))
	elif(game_info["map"]["map_type"] == 4):
		set_tileset(load("res://Assets/TileSets/Desert.tres"))
	elif(game_info["map"]["map_type"] == 5):
		set_tileset(load("res://Assets/TileSets/Grass.tres"))
	else: set_tileset(load("res://Assets/TileSets/Dirt.tres"))
	
	#we get the staring positions
	var pos1 = Vector2( 64+32, 64+32 ) 
	var pos2 = Vector2( 64*13+32, 64+32 )
	var pos3 = Vector2( 64+32 , 10*64 - 32 )
	var pos4 = Vector2( 64*13 +32 ,10*64-32 )
	
	
	
	var positions = [pos1,pos2,pos3,pos4]
	positions = shuffle_list(positions)
	
	var p1
	var p2
	var p3
	var p4
	
	
	p1 = load("res://Player/Player.tscn").instance()
	
	#here we spawn the players, or bots, depending 
	#on the choices at the prevoius scene
	if game_info["P2"]["is_playing"] :
		if game_info["P2"]["is_bot"] :
			p2 = load("res://Bot/Bot.tscn").instance()
		else:
			p2 = load("res://Player/Player.tscn").instance()
	
	if game_info["P3"]["is_playing"] :
		if game_info["P3"]["is_bot"] :
			p3 = load("res://Bot/Bot.tscn").instance()
		else:
			p3 = load("res://Player/Player.tscn").instance()
			
	if game_info["P4"]["is_playing"] :
		if game_info["P4"]["is_bot"] :
			p4 = load("res://Bot/Bot.tscn").instance()

		else:
			p4 = load("res://Player/Player.tscn").instance()
	
	var players=[p1,p2,p3,p4]
	
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
			if color == 0:
				i.color = Color(0,0,0,1)
			elif color == 1:
				i.color = Color( 0.8, 0.36, 0.36, 1 )
			elif color == 2:
				i.color = Color( 0.69, 0.88, 0.9, 1 )
			elif color == 3:
				i.color = Color( 0.6, 0.98, 0.6, 1 )
			elif color == 4:
				i.color = Color( 1, 1, 0, 1 )
			elif color == 5:
				i.color = Color( 0.55, 0.55, 0.55, 1 )
			elif color == 6:
				i.color = Color( 1, 0.41, 0.71, 1 )
			i._check_color()
			i.score = 0
		j+=1
	
	active_players = player_count
	resize_count = 1
	resize_time = Timer.new()
	resize_time.start(45)
	add_child(resize_time)
	resize_time.connect("timeout", self, "_on_resize_time_timeout")


#that function is called when somebody wins the game
func winnerWinnerChickenDinner():
	#here we rank our players
	var _score_pair = load("res://Highscore/ScorePair.gd")
	var score_pair
	var scores_arr: Array
	for i in scores.keys():
		score_pair = _score_pair.new()
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
	
	#Sounds.get_node("GamePlay").stop()
	
func _on_resize_time_timeout():
	resize()
	
func _process(delta):
	pass
		
