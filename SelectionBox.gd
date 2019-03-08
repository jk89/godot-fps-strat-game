extends Control

onready var treeRoot = get_tree().get_root()
onready var cameraMain = treeRoot.find_node("CameraMain", true, false)
onready var boundRect = treeRoot.find_node("TextureRect", true, false)
onready var worldNode = treeRoot.find_node("main", true, false)
var initial
var current
var camera



# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	camera = cameraMain
	#print(player)
	#print(selectable_nodes)
	set_process_input(true)
	pass

func _input(event):
	CreateBox(event)
	if initial and current and dragging:
		boundRect.set_position(initial)
		boundRect.set_size(Vector2(current.x - initial.x, current.y - initial.y)) #Vector2(100, 100)

var dragging = false
func CreateBox(event):
	if event is InputEventMouseMotion:
		current = event.position
	if Input.is_action_just_pressed("click_left"):
		initial = event.position
		dragging = true
		set_begin(event.position)
	elif Input.is_action_pressed("click_left"):
		set_begin(Vector2(min(initial.x, current.x), min(initial.y, current.y)))
		set_end(Vector2(max(initial.x, current.x), max(initial.y, current.y)))
		#boundRect.get_rect().size = Vector2(current.x - initial.x, current.y - initial.y)
		#boundRect.set_begin(Vector2(min(initial.x, current.x), min(initial.y, current.y)))
		#boundRect.set_begin(Vector2(max(initial.x, current.x), max(initial.y, current.y)))
	elif Input.is_action_just_released("click_left"):
		dragging = false
		SelectObject()
		boundRect.set_position(Vector2(0, 0))
		boundRect.set_size(Vector2(0, 0))
		#set_begin(Vector2(0, 0))
		#set_end(Vector2(0, 0))

func SelectObject():
	var selfRect = get_rect()
	print(worldNode.allSelectableUnits)
	for object in worldNode.allSelectableUnits:# #[treeRoot.find_node("world", true, false).find_node("player")]:
		#print(object)
		if object.is_class("Spatial") or object.is_class("KinematicBody"):
			print("selected node")
			object.emit_signal("select", selfRect.has_point(camera.unproject_position(object.get_transform().origin)))
			pass
		elif object.is_class("CanvasItem"):
			object.emit_signal("select", selfRect.has_point(object.get_pos()))
			pass
func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass