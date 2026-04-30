extends Node2D

const MIND_MAP_SHAPE = preload("uid://blg8e8og61qup")

var connect_mode = false
var first_node = null
var connections = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RenderingServer.set_default_clear_color(Color("e4e4e4ff"))

func _process(delta: float) -> void:
	for c in connections:
		c["line"].points = [
			c["a"].global_position,
			c["b"].global_position
		]

func toggle_connect_mode() -> void:
	connect_mode = !connect_mode
	first_node = null
	print("Connect mode: " + str(connect_mode))

func _on_shape_clicked(node) -> void:
	if not connect_mode:
		return
	
	if first_node == null:
		first_node = node
		print("selected first node")
	else:
		create_connection(first_node, node)
		first_node = null

func create_connection(a, b) -> void:
	var line = Line2D.new()
	
	line.width = 3
	line.default_color = Color("000000ff")
	line.z_index = -10
	
	line.points = [
		a.global_position,
		b.global_position
	]
	
	add_child(line)
	
	connections.append({
		"a": a,
		"b": b,
		"line": line
	})
