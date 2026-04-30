extends Control

@onready var sub_viewport: SubViewport = $SubViewportContainer/SubViewport
@onready var mind_map: Node2D = $SubViewportContainer/SubViewport/MindMap
@onready var label: Label = $Label

const MIND_MAP_SHAPE = preload("uid://blg8e8og61qup")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sub_viewport.gui_disable_input = false
	sub_viewport.handle_input_locally = true
	pass # Replace with function body.


func _on_add_shape_pressed() -> void:
	var shape = MIND_MAP_SHAPE.instantiate()
	
	shape.position = Vector2(480, 288)
	mind_map.add_child(shape)
	shape.clicked.connect(mind_map._on_shape_clicked)


func _on_connect_shapes_pressed() -> void:
	mind_map.toggle_connect_mode()
	label.text = "Connect Mode: " + str(mind_map.connect_mode)
