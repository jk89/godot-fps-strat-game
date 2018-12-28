extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process_input(true)
	hide_boundingSelector()
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

onready var treeRoot = get_tree().get_root()
onready var leftTexture = treeRoot.find_node("TextureRectLeft", true, false)
onready var rightTexture = treeRoot.find_node("TextureRectRight", true, false)
onready var bottomTexture = treeRoot.find_node("TextureRectBottom", true, false)
onready var topTexture = treeRoot.find_node("TextureRectTop", true, false)

const lineThickness = 2

var size = Vector2(10, 10)
var position = Vector2(0, 0)

var clickOrigin = Vector2(0 ,0)
var clickDestination = Vector2(10, 20)
var limitedMousePosition = Vector2(0, 0)

func calculateLimitedMousePosition(event):
	print(event.position)
	if event.position.x >= clickOrigin.x:
		limitedMousePosition.x = event.position.x
	if event.position.y >= clickOrigin.y:
		limitedMousePosition.y = event.position.y

var dragging = false
func _input(event):
	if event is InputEventMouseButton:
		calculateLimitedMousePosition(event)
		if event.button_index == BUTTON_LEFT:
			if Input.is_action_pressed("click_left"):
				print("left pressed")
				dragging = true
				clickDestination = limitedMousePosition
				clickOrigin = limitedMousePosition
				reshape_boundingSelector()
				pass
			else:
				print("left released")
				dragging = false
				clickDestination = limitedMousePosition
				reshape_boundingSelector()
				pass
		elif event.button_index == BUTTON_RIGHT:
			if Input.is_action_pressed("click_right"):
				hide_boundingSelector()
	elif event is InputEventMouseMotion:
		calculateLimitedMousePosition(event)
		clickDestination = limitedMousePosition
		reshape_boundingSelector()
		pass


func _process(delta):
	

	
	
	pass

func hide_boundingSelector():
	topTexture.set_size(Vector2(0, 0))
	topTexture.set_position(Vector2(0, 0))
	bottomTexture.set_size(Vector2(0, 0))
	bottomTexture.set_position(Vector2(0, 0))
	leftTexture.set_size(Vector2(0, 0))
	leftTexture.set_position(Vector2(0, 0))
	rightTexture.set_size(Vector2(0, 0))
	rightTexture.set_position(Vector2(0, 0))

func reshape_boundingSelector():
	if not dragging:
		return
		#top
	var topPos = Vector2(clickOrigin.x, clickOrigin.y - int(lineThickness / 2))
	var topSize = Vector2(clickDestination.x - clickOrigin.x, lineThickness)
	topTexture.set_size(topSize)
	topTexture.set_position(topPos)
	#bottom 
	var bottomPos = Vector2(clickOrigin.x, clickDestination.y - int(lineThickness / 2))
	var bottomSize = Vector2(clickDestination.x - clickOrigin.x, lineThickness)
	bottomTexture.set_size(bottomSize)
	bottomTexture.set_position(bottomPos)
	#left
	var leftPos = Vector2(clickOrigin.x -int(lineThickness / 2), clickOrigin.y)
	var leftSize = Vector2(lineThickness, clickDestination.y - clickOrigin.y)
	leftTexture.set_size(leftSize)
	leftTexture.set_position(leftPos)
	#right
	var rightPos = Vector2(clickDestination.x -int(lineThickness / 2), clickOrigin.y)
	var rightSize = Vector2(lineThickness, clickDestination.y - clickOrigin.y)
	rightTexture.set_size(rightSize)
	rightTexture.set_position(rightPos)
