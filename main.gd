extends Spatial

#onready var player = preload("res://player.tscn")

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


onready var cameraMain = $Control/ViewportContainerMain/ViewportMain/CameraMain
onready var cameraMap = $Control/ViewportContainerMap/ViewportMap/CameraMap
onready var world = $Control/ViewportContainerMain/ViewportMain/world
onready var treeRoot = get_tree().get_root()
onready var viewportMain = treeRoot.find_node("ViewportMain", true, false)
onready var viewportMap = treeRoot.find_node("ViewportMap", true, false)
onready var worldNode = self#treeRoot.find_node("world", true, false)
onready var allSelectableUnits = []
func _ready():
	viewportMap.world = viewportMain.world
	print(viewportMap)
	pass
	# Called when the node is added to the scene for the first time.
	# Initialization here
	randomize()
	#allSelectableUnits.push_front(self.find_node("player"))
	for i in range(5):
		var player = preload("res://player2.tscn")
		var s = player.instance()
		#s.set_name("kek")
		s.translation = Vector3(rand_range(1,11), rand_range(1,11), rand_range(1,11))
		self.add_child(s)
		allSelectableUnits.push_front(s)


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
