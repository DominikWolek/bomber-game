extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
func character_behaviour():
    velocity = Vector2()
    if Input.is_action_pressed("ui_right"):
        velocity.x += 1
    if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
    if Input.is_action_pressed("ui_down"):
        velocity.y += 1
    if Input.is_action_pressed("ui_up"):
        velocity.y -= 1
    velocity = velocity.normalized() * speed

var danger_list = Array()

func _ready():
	get_parent().connect("explosion", self, "_on_Bomb_explosion", danger_list)
	
func _on_Bomb_explosion(danger_list):
	for i in danger_list:
		print(i)
	
func _physics_process(delta):
	character_behaviour()
	move_and_slide(velocity)
	if(Input.is_action_just_pressed("ui_select")):
		get_parent().place_bomb(position, "test",2)