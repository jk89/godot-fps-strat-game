extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 700
var gravity = -9.8
var direction = Vector3()
var velocity = Vector3()
onready var treeRoot = get_tree().get_root()
onready var worldNode = treeRoot.find_node("main", true, false)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	self.connect("select", self, "select_callback")
	self.connect("move", self, "move_callback")
	pass

signal select(vis)
signal move(target)

var myTarget
func move_callback(target):
	print("Got callback move target with args! target", target)
	if (target and selected):
		myTarget = target


var selected = false
func select_callback(vis):
	print("000")
	print(worldNode.translation)
	print("Got callback with args! vis: ", vis)
	var myMesh = self.find_node("MeshInstance")
	var surface_material = myMesh.get_surface_material(0)
	if vis:
		surface_material.albedo_color = Color8(0, 255, 0)
		myMesh.set_surface_material(0, surface_material)
		selected = true
		print(surface_material)
	else:
		surface_material.albedo_color = Color8(255, 0, 0) # ff0000
		myMesh.set_surface_material(0, surface_material)
		selected = false
		print(surface_material)
var a = null
func nearTarget():
	if myTarget:
		var xDisplacementNearEnough
		xDisplacementNearEnough = abs(self.translation.x - myTarget.position.x) < 1.1
		var yDisplacementNearEnough
		yDisplacementNearEnough = abs(self.translation.y - myTarget.position.y) < 1.1
		if (xDisplacementNearEnough and yDisplacementNearEnough):
			return true
	return false

func _physics_process(delta):
	if is_on_floor(): # Only allow for direction modifications if we are on the floor, no bunny hopping
		direction = Vector3(0, 0, 0)
		if myTarget and self.translation.x > myTarget.position.x:
			direction.x -= 1
		if Input.is_action_pressed("left-wasd"): # ui_left
			direction.x -= 1
		if myTarget and self.translation.x < myTarget.position.x:
			direction.x += 1
		if Input.is_action_pressed("right-wasd"): #ui_right
			direction.x += 1
		if myTarget and self.translation.z > myTarget.position.z:
			direction.z -= 1
		if Input.is_action_pressed("up_wasd"): #ui_up
			direction.z -= 1
		if myTarget and self.translation.z < myTarget.position.z:
			direction.z += 1
		if Input.is_action_pressed("down_wasd"): #ui_down
			print("move down")
			direction.z += 1

	direction = direction.normalized()
	direction = direction * speed * delta
	velocity.y += gravity * delta
	velocity.x = direction.x
	velocity.z = direction.z
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
	if is_on_floor() and Input.is_key_pressed(KEY_SPACE):
		velocity.y = 11
	if nearTarget():
		myTarget = null