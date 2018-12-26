extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 700
var gravity = -9.8
var direction = Vector3()
var velocity = Vector3()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	if is_on_floor(): # Only allow for direction modifications if we are on the floor, no bunny hopping
		direction = Vector3(0, 0, 0)
		if Input.is_action_pressed("ui_left"):
			direction.x -= 1
		if Input.is_action_pressed("ui_right"):
			direction.x += 1
		if Input.is_action_pressed("ui_up"):
			direction.z -= 1
		if Input.is_action_pressed("ui_down"):
			direction.z += 1
	direction = direction.normalized()
	direction = direction * speed * delta
	velocity.y += gravity * delta
	velocity.x = direction.x
	velocity.z = direction.z
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
	if is_on_floor() and Input.is_key_pressed(KEY_SPACE):
		velocity.y = 11