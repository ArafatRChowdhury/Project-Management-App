extends Control

@onready var texture_rect: TextureRect = $ColorRect/VBoxContainer/PanelContainer/HBoxContainer/TextureRect
@onready var panel_container: PanelContainer = $ColorRect/VBoxContainer/PanelContainer
@onready var item_label: Label = $ColorRect/VBoxContainer/PanelContainer/HBoxContainer/VBoxContainer/ItemLabel
@onready var effect_label: Label = $ColorRect/VBoxContainer/PanelContainer/HBoxContainer/VBoxContainer/EffectLabel
@onready var price_label: Label = $ColorRect/VBoxContainer/PanelContainer/HBoxContainer/VBoxContainer/PriceLabel
@onready var inventory_label: Label = $ColorRect/VBoxContainer/PanelContainer/HBoxContainer/VBoxContainer/InventoryLabel
@onready var button: Button = $ColorRect/Button
@onready var error_label: Label = $ColorRect/VBoxContainer/ErrorLabel

const SWORD = preload("uid://blicpjbkb8fir")
const BOMB = preload("uid://omtxntum7ina")

var current_selected_item: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#texture_rect.set_texture(BOMB)
	item_label.text = "Select an item!"
	effect_label.text = ""
	price_label.text = ""
	inventory_label.text = ""

func _on_buy_sword_pressed() -> void:
	current_selected_item = "swords"
	texture_rect.set_texture(SWORD)
	item_label.text = "Item: Sword"
	effect_label.text = "Effect: -10 hp 1 enemy"
	price_label.text = "Price: 30 coins"
	inventory_label.text = "Held: " + str(InventoryManager.swords)
	print(current_selected_item)

func _on_buy_bomb_pressed() -> void:
	current_selected_item = "bombs"
	texture_rect.set_texture(BOMB)
	item_label.text = "Item: Bomb"
	effect_label.text = "Effect: -5 hp all enemies"
	price_label.text = "Price: 70 coins"
	inventory_label.text = "Held: " + str(InventoryManager.bombs)
	print(current_selected_item)


func _on_button_pressed() -> void:
	if current_selected_item == "swords":
		if CoinManager.coins >= 30:
			InventoryManager.swords += 1
			CoinManager.remove_coins(30)
			InventoryManager.inventory_updated()
			error_label.text = "Purchase Successful!"
			inventory_label.text = "Held: " + str(InventoryManager.swords)
			button.disabled = true
			await get_tree().create_timer(2.0).timeout
			button.disabled = false
			error_label.text = ""
		else:
			error_label.text = "Not enough coins!"
			await get_tree().create_timer(2.0).timeout
			error_label.text = ""
	elif current_selected_item == "bombs":
		if CoinManager.coins >= 70:
			InventoryManager.bombs += 1
			print(str(InventoryManager.bombs))
			CoinManager.remove_coins(70)
			InventoryManager.inventory_updated()
			error_label.text = "Purchase Successful!"
			inventory_label.text = "Held: " + str(InventoryManager.bombs)
			button.disabled = true
			await get_tree().create_timer(2.0).timeout
			button.disabled = false
			error_label.text = ""
		else:
			error_label.text = "Not enough coins!"
			await get_tree().create_timer(2.0).timeout
			error_label.text = ""
