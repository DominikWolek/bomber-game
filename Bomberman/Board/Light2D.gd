extends Light2D

var time
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	time = Timer.new()
	time.start(0.3)
	add_child(time)
	time.connect("timeout", self, "_on_Timer_timeout")


func _on_Timer_timeout():
	time.queue_free()
	queue_free()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	energy *= 1.85
