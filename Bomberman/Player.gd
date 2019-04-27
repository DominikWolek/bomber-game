extends KinematicBody2D


var Hp = 3
var maxBombs = 1
var canPlant = 1
var canKick = false
var isImmortal = false
var bombDMG = 1

export (int) var speed = 200

var velocity = Vector2()

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
	if Input.is_action_pressed('ui_select'):
		print ("XD")


func _physics_process(delta):
    get_input()
    move_and_slide(velocity)
