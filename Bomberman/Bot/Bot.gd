extends "res://Player/Player.gd" # inherits from the player

const right_vector = Vector2(64,0)
const left_vector = Vector2(-64,0)
const up_vector = Vector2(0,-64)
const down_vector = Vector2(0,64)


var position_to_achieve = position # the position that the bot will have to achieve when it is in motion
var moving = false # at the beginning, the bot does not move
var direction = "none" # current direction of the bot's movement
var stop = false # in case the bot is blocked, he must stop moving

"""

Method name: random_plant
Arguments: none
After 1.5 seconds the bot has a 50% chance that he will set the bomb if he can.
After the try of planting the bomb, the random_planting () function is called.
"""
func random_plant():
	randomize()
	if (randi() % 2) == 0: # 50% chance to set a bomb
		plant_bomb()
	random_planting()

"""
Method name: random_planting
Arguments: none
He is responsible for setting the timer for 1.5 seconds, after 
this time the random_plant function will be executed (which is 
in the bot, hence the self argument in the timer.connect call)
"""
func random_planting():
	var timer = Timer.new()
	timer.set_one_shot(true) # single timer call
	timer.set_wait_time(1.5) 
	timer.connect("timeout", self, "random_plant") # after the timeout has elapsed, the random_plant function will be called
	add_child(timer)
	timer.start() # start counting the time

"""
Method name: _ready
Arguments: none
The function is responsible for starting a random bomb placement by the bot
and for things performed in the Player's _ready function
"""
func _ready():
	random_planting()
# here will be executed _ready from the Player

"""
Nazwa metody: play_animation
Arguments: none
The function responsible for loading the appropriate bot animation 
(depending on the direction in which it moves and whether it is immortal).
"""
func play_animation():
	var temp = ""	
	if (is_immortal):
		temp = "_IMMORTAL"
	if direction == "right":
		$Sprite.flip_h = false 
		$Sprite.play("run"+temp)
	elif direction == "left":
		$Sprite.flip_h = true # mirror image of animation set to true (default animations apply to move right / up / down)
		$Sprite.play("run"+temp)
	elif direction == "up":
		$Sprite.play("runUP"+temp)
	elif direction == "down":
		$Sprite.play("runDOWN"+temp)
	else: $Sprite.play("idle"+temp) # if the direction == "none" bot loads animations of standing in place

"""
Method name: check_movement
Arguments: position - the position in which the bot is located, 
prev_dir - the previous direction of the bot's movement
The function checks in which direction the bot can move from its current position. Index == 0 means move to the right, 1 to the left,
2 up, 3 down. The chance of moving in the opposite direction to the previous direction is less likely to happen
(to make the bot look more natural). The values ​​in the array of directions are set in a non-trivial order which
makes it easier to determine a new direction in the new_direction function.
The function returns the completed array of directions.
"""
func check_movement(position,prev_dir):
	var array = [0,0,0,0]
	var index = 0
	var tile_index = get_parent().cellv_from_position(position+right_vector)
	if (tile_index!=2 and tile_index!=0): # if it is not a breakable/unbreakable block(on the right)
		if (prev_dir == "left"): # if the previous direction of movement was the direction opposite to the right direction
			array[index] = 2 # smaller value => less probability of determining this direction from all possible directions
		else: array[index] = 15
	index += 1
	tile_index = get_parent().cellv_from_position(position+left_vector)
	if (tile_index!=2 and tile_index!=0): # if it is not a breakable/unbreakable block(on the left)
		if (prev_dir == "right"):
			array[index] = 2
		else: array[index] = 15
	array[index] += array[index-1]
	index += 1
	tile_index = get_parent().cellv_from_position(position+up_vector)
	if (tile_index!=2 and tile_index!=0): # if it is not a breakable/unbreakable block(above)
		if (prev_dir == "down"):
			array[index] = 2
		else: array[index] = 15
	array[index] += array[index-1]
	index += 1
	tile_index = get_parent().cellv_from_position(position+down_vector)
	if (tile_index!=2 and tile_index!=0): # if it is not a breakable/unbreakable block(below)
		if (prev_dir == "up"):
			array[index] = 2
		else: array[index] = 15
	array[index] += array[index-1]
	return array

"""
Method name: new_direction
Arguments: position - the position in which the bot is located, 
prev_dir - the previous direction of the bot's movement
The function based on the array with the directions of the bot randomly 
calculates in which direction the bot will move.
Returns the new direction of the bot's movement.
"""
func new_direction(position, prev_dir):
	var array = check_movement(position,prev_dir) # the check_movement function returns the completed array of directions
	if array[3] == 0: # the case when the bot is exposed on each side by blocks
		stop = true
		return "none"
	else: 
		stop = false # bot is not forced to stop in place
		randomize()
		var random_number = randi() % array[3] # array elements are set to non-decreasing order
		if (random_number < array[0]): # in this case, move to the right
			return "right"
		elif (random_number < array[1]): # in this case, move to the left
			return "left"
		elif (random_number < array[2]): # in this case, move up
			return "up"
		else: # otherwise, move down
			return "down"

"""
Method name: opposite_direction
Arguments: none
The function returns the opposite direction to the current direction of the bot's movement.
If direction is none, the direction must be set up again by calling new_direction.
"""
func opposite_direction():
	if (direction == "right"):
		return "left"
	elif (direction == "left"):
		return "right"
	elif (direction == "up"):
		return "down"
	elif (direction == "down"): 
		return "up"
	else: return new_direction(position, direction) # if not defined


"""
Method name: can_destroy
Arguments: position - the place where the bomb will be put
vector - direction vector, defines in which direction we check the possibility of destroying a block.
The function checks whether towards the vector direction from the position (position) an object will be destroyed
(if the bomb is placed in coordinates position)
"""
func can_destroy(position, vector):
	for i in range(bomb_dmg):
		var tile_index = get_parent().cellv_from_position(position+(i+1)*vector)
		if (tile_index == 2): # this is the index of the destructible block
			return true
		elif (tile_index == 0): # if we hit an indestructible block, it makes no sense to check further blocks (behind it)
			return false
	return false # alse returned means that there is no breakable / unbreakable block in the vector direction

"""
Method name: possible_plant
Arguments: position - the position at which a check is made, whether
putting a bomb would cause destruction of an object.
The function checks whether a destructible object would be destroyed 
when the bomb was placed. Returns true if yes, false if not.
"""
func possible_plant(position):
	if can_plant > 0:
		if (can_destroy(position, right_vector)):
			return true
		if (can_destroy(position, left_vector)):
			return true
		if (can_destroy(position, up_vector)):
			return true
		if (can_destroy(position, down_vector)):
			return true
	return false

"""
Method name: character_behaviour
Argument: None
If the bot does not move (is in place / reached position_to_achieve), if it makes sense to 
put a bomb, i.e. if a block may be destroyed (possible_plant), it has a 50% chance to place
a bomb. If it is planted, bot will change the direction of movement.
Otherwise, the new direction of movement is determined by calling the new_direction function.
If the bot is not forced to stop (in case it is not surrounded on each side by destructible / indestructible
objects) then the vector of the bot's movement direction, and the target position bot will have to achieve 
is updated.
"""
func character_behaviour(): 
	if moving == false:
		if (possible_plant(position)):
			randomize()
			if (randi() % 2) == 0:
				plant_bomb()
				direction = opposite_direction()
			else: direction = new_direction(position, direction)
		else: 
			direction = new_direction(position, direction)
		if !stop:
			moving = true
			if (direction == "right"):
				velocity.x += 1
				position_to_achieve = position + right_vector
			elif (direction == "left"):
				velocity.x -= 1
				position_to_achieve = position + left_vector
			elif (direction == "up"):
				velocity.y -= 1
				position_to_achieve = position + up_vector
			else: 
				velocity.y += 1
				position_to_achieve = position + down_vector
		velocity *= speed
		play_animation()
	move_and_slide(velocity) # the function responsible for the smooth movement of the characters, the so-called sliding

"""
Method name: _physic_process
Arguments: delta
Responsible for the actualization of damage from the bot bomb, execution 
of the character_behaviour function (this instruction and calling the 
function is in the Player) and for checking whether the bot reached the 
right place, which was previously determined in the character_behavior function.
"""
func _physics_process(delta):
	if (direction == "right"): # if the direction of moving the bot is the right direction
		if (position.x >= position_to_achieve.x): # if the player's position is >= from the target position
			position.x = position_to_achieve.x # place the bot on the position_to_achieve
			moving = false # check that the player has stopped moving and stands in the final place
			velocity = Vector2() # resetting the vector of movement of the bot
# other conditions analogously
	if (direction == "left"):
		if (position.x <= position_to_achieve.x):
			position.x = position_to_achieve.x
			moving = false
			velocity = Vector2()
	if (direction == "up"):
		if (position.y <= position_to_achieve.y):
			position.y = position_to_achieve.y
			moving = false
			velocity = Vector2()
	if (direction == "down"):
		if (position.y >= position_to_achieve.y):
			position.y = position_to_achieve.y
			moving = false
			velocity = Vector2()
# here we perform _physic_process from the Player
