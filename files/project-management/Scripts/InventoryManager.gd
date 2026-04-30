extends Node

var swords: int = 0
var bombs: int = 0

signal item_update

# Called when the node enters the scene tree for the first time.
func inventory_updated() -> void:
	emit_signal("item_update")
