extends Control

onready var treeRoot = get_tree().get_root()
onready var cameraMain = treeRoot.find_node("CameraMain", true, false)
onready var boundRect = treeRoot.find_node("TextureRect", true, false)
onready var worldNode = treeRoot.find_node("world", true, false)
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

var selectCount = 0
var singleTarget = null
func SelectObject():
	selectCount = 0
	singleTarget = null
	var selfRect = get_rect()
	for object in worldNode.allSelectableUnits:# #[treeRoot.find_node("world", true, false).find_node("player")]:
		var selected
		if object.is_class("Spatial") or object.is_class("KinematicBody"):
#			print(object.path)
			selected = selfRect.has_point(camera.unproject_position(object.get_transform().origin))
			object.emit_signal("select", selected, object.name)
			pass
		elif object.is_class("CanvasItem"):
			selected = selfRect.has_point(object.get_pos())
			object.emit_signal("select", selected, object.name)
			pass
		if (selected):
			singleTarget = object
			selectCount = selectCount + 1
	if (selectCount == 1):
		cameraMain.emit_signal("toggleTrackTarget", singleTarget)
	else:
		cameraMain.emit_signal("toggleTrackTarget", null)
			
func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass