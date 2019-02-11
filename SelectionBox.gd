extends Control

onready var treeRoot = get_tree().get_root()
onready var cameraMain = treeRoot.find_node("CameraMain", true, false)

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
	CreateBox()

func CreateBox():
	if Input.is_action_just_pressed("click_left"):
		initial = get_global_mouse_position()
		set_begin(initial)
	elif Input.is_action_pressed("click_right"):
		current = get_global_mouse_position()
		set_begin(Vector2(min(initial.x, current.x), min(initial.y, current.y)))
		set_end(Vector2(max(initial.x, current.x), max(initial.y, current.y)))
	elif Input.is_action_just_released("click_left"):
		SelectObject()
		set_begin(Vector2(0, 0))
		set_end(Vector2(0, 0))

func SelectObject():
	var selfRect = get_rect()
	for object in [treeRoot.find_node("world", true, false).find_node("player")]:
		if object.is_class("Spatial") or object.is_class("KinematicBody"):
			print("selected node")
			object.emit_signal("select", selfRect.has_point(camera.unproject_position(object.get_transform().origin)))
			pass
		elif object.is_class("CanvasItem"):
			object.emit_signal("select", selfRect.has_point(object.get_pos()))
			pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
