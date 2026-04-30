class_name overlay
extends Control

@onready var main_content: Control = $MainContent
@onready var coins: Label = $Coins

const QUESTS_UI = preload("uid://bn46p475waji7")
const KANBAN_BOARD = preload("uid://dm7ij3r7d0yd6")
const SHOP = preload("uid://dh6n7t1ss31ll")
const MIND_MAP_UI = preload("uid://dr1xqk1yc6fmd")
const BATTLEFIELD = preload("uid://b53afig1vc8em")

var views = {}
var current_view: Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	refresh_coin_count()
	CoinManager.coins_changed.connect(_on_coins_changed)
	load_view("quests", QUESTS_UI)

func refresh_coin_count() -> void:
	coins.text = "Coins: " + str(CoinManager.coins)

func _on_coins_changed(new_amount: int):
	refresh_coin_count()

#all the buttons should remove the current node in MainContent from the screen
#then add its respective scene to that MainContent node
func _on_quest_button_pressed() -> void:
	load_view("quests", QUESTS_UI)
	print("quests loaded")

func _on_mind_map_button_pressed() -> void:
	load_view("mind map", MIND_MAP_UI)
	print("mind map loaded")

func _on_kanban_board_button_pressed() -> void:
	load_view("kanban board", KANBAN_BOARD)
	print("kanban board loaded")

func _on_shop_button_pressed() -> void:
	load_view("shop", SHOP)
	print("shop loaded")

func _on_battlefield_button_pressed() -> void:
	load_view("battlefield", BATTLEFIELD)
	print("battlefield loaded")

func load_view(name: String, scene: PackedScene) -> void:
	if current_view && current_view.name == name:
		return
	
	if current_view:
		current_view.hide()
	
	if not views.has(name):
		var instance = scene.instantiate()
		main_content.add_child(instance)
		views[name] = instance
	
	current_view = views[name]
	current_view.show()
	pass
