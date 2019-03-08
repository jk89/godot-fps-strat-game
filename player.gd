extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 1000
var gravity = -9.8
var direction = Vector3()
var velocity = Vector3()
onready var treeRoot = get_tree().get_root()
onready var worldNode = treeRoot.find_node("main", true, false)


func _ready():
	#print ("im alive2")
	#set_as_toplevel(true)
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
	if (target and selected): #selected
		myTarget = target


var selected = false
func select_callback(vis, name):
	print("Got callback with args! vis: ", vis, name, self.name)
	if (self.name != name):
		return
	#print("000")
	#print(worldNode.translation)
	var myMesh = self.find_node("MeshInstance")
	var newMaterial = SpatialMaterial.new()
	var surface_material = myMesh.get_surface_material(0)
	if vis:
		newMaterial.albedo_color = Color8(0, 255, 0)
		newMaterial.metallic = 1
		newMaterial.metallic_specular = 1
		myMesh.set_surface_material(0, newMaterial)
		selected = true
	else:
		newMaterial.albedo_color = Color8(255, 0, 0) # ff0000
		newMaterial.metallic = 1
		newMaterial.metallic_specular = 1
		myMesh.set_surface_material(0, newMaterial)
		selected = false
	print("selected?", selected)
var a = null
func nearTarget():
	if myTarget:
		var xDisplacementNearEnough
		xDisplacementNearEnough = abs(self.translation.x - myTarget.position.x)  < 1.001
		var yDisplacementNearEnough
		yDisplacementNearEnough = abs(self.translation.y - myTarget.position.y) < 1.001
		if (xDisplacementNearEnough and yDisplacementNearEnough):
			return true
	return false

func _physics_process(delta):
	if is_on_floor(): # Only allow for direction modifications if we are on the floor, no bunny hopping
		direction = Vector3(0, 0, 0)
		if myTarget and self.translation.x > myTarget.position.x:
			direction.x -= abs(self.translation.x - myTarget.position.x)* speed / delta
			#print("leeefft")
		if Input.is_action_pressed("left-wasd"): # ui_left
			direction.x -= 1
		if myTarget and self.translation.x < myTarget.position.x:
			direction.x += abs(self.translation.x - myTarget.position.x)* speed / delta
			#print("rigghhht")
		if Input.is_action_pressed("right-wasd"): #ui_right
			direction.x += 1
		if myTarget and self.translation.z > myTarget.position.z:
			direction.z -= abs(self.translation.z - myTarget.position.z)* speed / delta
			#print("upppp")
		if Input.is_action_pressed("up_wasd"): #ui_up
			direction.z -= 1
		if myTarget and self.translation.z < myTarget.position.z:
			direction.z += abs(self.translation.z - myTarget.position.z)* speed / delta
			#print("downnnn")
		if Input.is_action_pressed("down_wasd"): #ui_down
			#print("move down")
			direction.z += 1

	direction = direction.normalized()
	direction = direction * speed * delta
	velocity.y += gravity * delta
	velocity.x = direction.x
	velocity.z = direction.z
	#print("player2 velocity")
	#print(velocity)
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
	if is_on_floor() and Input.is_key_pressed(KEY_SPACE):
		velocity.y = 11
	if nearTarget():
		myTarget = null