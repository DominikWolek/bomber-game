extends KinematicBody2D

var Name = "nickname"
var hp = 3
var maxBombs = 1
var canPlant = 1
var canKick = false
var isImmortal = false
var bombDMG = 1

export (int) var speed = 200

var velocity = Vector2()

func plant_bomb():
	var bomb = preload("res://Bomb.tscn").instance()
	bomb.who_planted = Name
	bomb.DMG = bombDMG
	bomb.position = position
	add_child(bomb)
	var timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(3)
	timer.connect("timeout",bomb,"explode")
	add_child(timer)
	timer.start()

func exploded(by_who):
	if isImmortal:
		return
	else:
		isImmortal = true #powinno trwac przez jakis czas a potem przejsc na false
		hp -= 1
		

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
	velocity = velocity.normalized() * speed
	if Input.is_action_pressed('ui_select'): #spacja (bomba)
		plant_bomb()


func _physics_process(delta):
    get_input()
    move_and_slide(velocity)
	
