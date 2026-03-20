extends Area3D

var speed : float = 30.0
var damage : int = 1


# Called when the node enters the scene tree for the first time.




func _process (delta):
	# move the bullet forwards
	global_transform.origin -= transform.basis.z.normalized() * speed * delta


func _on_body_entered(body): 
	if body.has_method("take_damage"):
		body.take_damage(damage)
		destroy()

func destroy():
	#destroys the bullet
	queue_free()
