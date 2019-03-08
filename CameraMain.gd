extends Camera
onready var treeRoot = get_tree().get_root()
onready var worldNode = treeRoot.find_node("world", true, false)
onready var space_state = worldNode.get_world().get_direct_space_state()
enum CameraMode {
	UNIT_TRACK,
	ISOMETRIC
}

var cameraMode = CameraMode.ISOMETRIC
var unitToTrack = null

func trackUnit(unit):
	unitToTrack = unit
	pass

signal toggleTrackTarget(target)

func _ready():
	self.connect("toggleTrackTarget", self, "trackUnit")
	set_process_input(true)
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

var speed = 50
var offset = Vector3()
var ray_length = 5000
var target

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed(): # zoom in
			if event.button_index == BUTTON_WHEEL_UP:
				scrollup = true
				# call the zoom function
	        # zoom out
			if event.button_index == BUTTON_WHEEL_DOWN:
				scrolldown = true
		if event.button_index == BUTTON_RIGHT:
			var from = self.project_ray_origin(event.position)
			var to = from + self.project_ray_normal(event.position) * ray_length
			target = space_state.intersect_ray( from, to )
			for object in worldNode.allSelectableUnits:
				#print("here")
				#print(object)
				object.emit_signal("move", target)




var scrollup = false
var scrolldown = false

func nearTarget():
	if unitToTrack:
		var xDisplacementNearEnough
		xDisplacementNearEnough = abs(self.translation.x - unitToTrack.translation.x)  < 1.001
		var yDisplacementNearEnough
		yDisplacementNearEnough = abs(self.translation.y - unitToTrack.translation.y) < 1.001
		if (xDisplacementNearEnough and yDisplacementNearEnough):
			return true
	return false

func _physics_process(delta):
	offset = Vector3(0, 0, 0)
	var pos = global_transform.origin
	if unitToTrack:
		var target = unitToTrack.translation.normalized() #0, -1, -1
		var up = Vector3(0, 1, 0)
		self.translation = unitToTrack.translation + Vector3(0, 5, 10)
		#self.look_at_from_position(pos, target, up)
		return
		if self.translation.x > unitToTrack.translation.x:
			offset.x -= abs(self.translation.x - unitToTrack.translation.x) * speed / delta
		if self.translation.x < unitToTrack.translation.x:
			offset.x += abs(self.translation.x - unitToTrack.translation.x) * speed / delta
		if self.translation.y > unitToTrack.translation.y:
			offset.y -= abs(self.translation.y - unitToTrack.translation.y) * speed / delta
		if self.translation.z < unitToTrack.translation.z:
			offset.y += abs(self.translation.y - unitToTrack.translation.y) * speed / delta
		if self.translation.z > unitToTrack.translation.z:
			offset.z -= abs(self.translation.z - unitToTrack.translation.z) * speed / delta
		if self.translation.z < unitToTrack.translation.z:
			offset.z += abs(self.translation.z - unitToTrack.translation.z) * speed / delta
		self.translate(target)

	else:
		var target = pos + Vector3(0, -1, -1).normalized() #0, -1, -1
		var up = Vector3(0, 1, 0)
		self.look_at_from_position(pos, target, up)
	
		if Input.is_action_pressed("ui_left"): # ui_left
			offset.x -= 1
		if Input.is_action_pressed("ui_right"): #ui_right
			offset.x += 1
		if Input.is_action_pressed("ui_up"): #ui_up
			offset.y += 1
			offset.z -= 1
		if Input.is_action_pressed("ui_down"): #ui_down
			offset.y -= 1
			offset.z += 1
		if Input.is_action_pressed("scroll_out") or scrolldown == true:
			offset.z -= 1
		if Input.is_action_pressed("scroll_in") or scrollup == true:
			offset.z += 1
		scrollup = false
		scrolldown = false
		offset = offset * speed * delta
		self.translate(offset)