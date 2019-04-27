extends KinematicBody2D

export (int) var acceleration = 10
export (int) var max_speed = 400
var idealframerate = 60

var velocity = Vector2()

func get_input(delta):
    if Input.is_action_pressed("ui_right"):
        velocity.x += acceleration * delta * idealframerate
    if Input.is_action_pressed("ui_left"):
        velocity.x -= acceleration * delta * idealframerate
    if Input.is_action_pressed("ui_down"):
        velocity.y += acceleration * delta * idealframerate
    if Input.is_action_pressed("ui_up"):
        velocity.y -= acceleration * delta * idealframerate
	
func resist():
	velocity *= 0.93
	
	if velocity.abs().x > max_speed:
		velocity.x = sign(velocity.x) * max_speed
	if velocity.abs().y > max_speed:
		velocity.y = sign(velocity.y) * max_speed
		
	
func _physics_process(delta):
	
	get_input(delta)
	resist()
	
	move_and_slide(velocity)