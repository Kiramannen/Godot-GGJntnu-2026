extends RigidBody2D

var speed = 3000 

func _physics_process(delta: float) -> void:
	var dir_v = Input.get_action_strength("push_right") - Input.get_action_strength("push_left")
	var dir_h = Input.get_action_strength("push_up") - Input.get_action_strength("push_down")
	
	if dir_v != 0 or dir_h != 0:
		apply_force(Vector2(dir_v * speed, dir_h * speed))
