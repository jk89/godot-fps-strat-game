extends Spatial

#onready var player = preload("res://player.tscn")

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var viewportMain = $Control/ViewportContainerMap/ViewportMain
onready var viewportMap = $Control/ViewportContainerMap/ViewportMap
onready var cameraMain = $Control/ViewportContainerMain/ViewportMain/CameraMain
onready var cameraMap = $Control/ViewportContainerMap/ViewportMap/CameraMap
onready var world = $Control/ViewportContainerMain/ViewportMain/world

func _ready():
	#viewportMap.world = viewportMain.world
	pass
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#randomize()
	#for i in range(500):
	#	var s = player.instance()
	#	add_child(s)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
