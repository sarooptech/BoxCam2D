extends Camera2D
class_name BoxCam2D

export var player: NodePath = ""

var player_pos = Vector2(0,0)
var box = Vector2(0,0)

onready var design_res: Vector2 = Vector2(ProjectSettings.get_setting("display/window/size/width"),ProjectSettings.get_setting("display/window/size/height"))

signal out_of_the_box

func _ready():
	
	if player == "":
		print("BoxCam2D: Assign Player Node in BoxCam2D using Inspector.")
		self.queue_free()
		return
	elif !self.current:
		print("BoxCam2D: Set 'Current' Enabled or it won't work.'")
		
	set_box_pos()
	if connect("out_of_the_box", self,"set_box_pos"):
		print("Box_Cam: Failed To Connect Signal")
	
func _process(_delta):
	
	player_pos = self.get_node(player).position
	
	var current_box = Vector2(floor(player_pos.x / (design_res.x * zoom.x)), floor(player_pos.y / (design_res.y * zoom.y)))
	
	if current_box.x != box.x or current_box.y != box.y:
		emit_signal("out_of_the_box")
		box = current_box

func set_box_pos():
	var box_pos_x = ((design_res.x * zoom.x) * floor(player_pos.x / (design_res.x * zoom.x)))
	var box_pos_y = ((design_res.y * zoom.y) * floor(player_pos.y / (design_res.y * zoom.y)))
	
	self.position.x = ((design_res.x / 2) * zoom.x) + box_pos_x
	self.position.y = ((design_res.y / 2) * zoom.y) + box_pos_y
