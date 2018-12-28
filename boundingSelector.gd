extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
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

func _process(delta):
	
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
	
	
	pass
