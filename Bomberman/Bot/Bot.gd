extends "res://Player/Player.gd"

const right_vector = Vector2(64,0)
const left_vector = Vector2(-64,0)
const up_vector = Vector2(0,-64)
const down_vector = Vector2(0,64)

var position_to_achieve = position # pozycja którą będzie musiał osiągnąć bot
var moving = false # na poczatku bot sie nie porusza
var direction = "none"
var stop = false


func check_movement(position,prev_dir):
	var array = [0,0,0,0]
	var index = 0
	var tile_index = get_parent().cellv_from_position(position+right_vector)
	if (tile_index!=2 and tile_index!=0): #jesli nie jest to skrzynka ani niezniszczalny obiekt (po prawej)
		if (prev_dir == "left"):
			array[index] = 2
		else: array[index] = 15
	index += 1
	tile_index = get_parent().cellv_from_position(position+left_vector)
	if (tile_index!=2 and tile_index!=0): #jesli nie jest to skrzynka ani niezniszczalny obiekt (po lewej)
		if (prev_dir == "right"):
			array[index] = 2
		else: array[index] = 15
	array[index] += array[index-1]
	index += 1
	tile_index = get_parent().cellv_from_position(position+up_vector)
	if (tile_index!=2 and tile_index!=0): #jesli nie jest to skrzynka ani niezniszczalny obiekt (powyzej)
		if (prev_dir == "down"):
			array[index] = 2
		else: array[index] = 15
	array[index] += array[index-1]
	index += 1
	tile_index = get_parent().cellv_from_position(position+down_vector)
	if (tile_index!=2 and tile_index!=0): #jesli nie jest to skrzynka ani niezniszczalny obiekt (ponizej)
		if (prev_dir == "up"):
			array[index] = 2
		else: array[index] = 15
	array[index] += array[index-1]
	return array

func _direction(position, prev_dir):
	var array = check_movement(position,prev_dir)
	if array[3] == 0:
		stop = true
		return "none"
	else: 
		stop = false
		randomize()
		var random_number = randi() % array[3]
		if (random_number < array[0]):
			return "right"
		elif (random_number < array[1]):
			return "left"
		elif (random_number < array[2]):
			return "up"
		else:
			return "down"

func can_destroy(position, vector):
	for i in range(bomb_dmg):
		var tile_index = get_parent().cellv_from_position(position+(i+1)*vector)
		if (tile_index == 2):
			return true
		elif (tile_index == 0):
			return false
	return false

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

func play_animation():
	var temp = ""	
	if (is_immortal):
		temp = "_IMMORTAL"
	if direction == "right":
		$Sprite.flip_h = false
		$Sprite.play("run"+temp)
	elif direction == "left":
		$Sprite.flip_h = true
		$Sprite.play("run"+temp)
	elif direction == "up":
		$Sprite.play("runUP"+temp)
	elif direction == "down":
		$Sprite.play("runDOWN"+temp)
	else: $Sprite.play("idle"+temp)

func opposite_direction(current_direction):
	if (direction == "right"):
		return "left"
	elif (direction == "left"):
		return "right"
	elif (direction == "up"):
		return "down"
	elif (direction == "down"): 
		return "up"
	else: return _direction(position, direction) # jeśli nie zdefiniowane

func get_input():
	if moving == false:
		if (possible_plant(position)):
			plant_bomb()
			direction = opposite_direction(direction)
		else: 
			direction = _direction(position, direction)
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

func random_plant():
	randomize()
	var random_number = randi() % 10
	if random_number <= 4:
		plant_bomb()
	random_planting()

func random_planting():
	var timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(1.5)
	timer.connect("timeout", self, "random_plant")
	add_child(timer)
	timer.start()


func _ready():
	random_planting()


func _physics_process(delta):
	if (direction == "right"):
		if (position.x > position_to_achieve.x):
			position.x = position_to_achieve.x
			moving = false
			velocity = Vector2()
	if (direction == "left"):
		if (position.x < position_to_achieve.x):
			position.x = position_to_achieve.x
			moving = false
			velocity = Vector2()
	if (direction == "up"):
		if (position.y < position_to_achieve.y):
			position.y = position_to_achieve.y
			moving = false
			velocity = Vector2()
	if (direction == "down"):
		if (position.y > position_to_achieve.y):
			position.y = position_to_achieve.y
			moving = false
			velocity = Vector2()
