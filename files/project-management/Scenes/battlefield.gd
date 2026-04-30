extends Control

@onready var sword: Button = $ColorRect/HBoxContainer/Sword
@onready var bomb: Button = $ColorRect/HBoxContainer/Bomb
@onready var slime: Control = $Slime
@onready var slime_2: Control = $Slime2
@onready var slime_3: Control = $Slime3
@onready var selected_weapon: Label = $ColorRect/SelectedWeapon

var current_weapon: String = "none"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InventoryManager.item_update.connect(update_inventory)
	update_inventory()
	selected_weapon.text = "Selected Weapon: " + current_weapon

func update_inventory() -> void:
	sword.text = str(InventoryManager.swords)
	bomb.text = str(InventoryManager.bombs)
	
	if InventoryManager.swords == 0:
		sword.disabled = true
	else:
		sword.disabled = false
	
	if InventoryManager.bombs == 0:
		bomb.disabled = true
	else:
		bomb.disabled = false

func use_sword(slime: Slime) -> void:
	slime.update_hp(3)
	slime.set_pressed(false)
	InventoryManager.swords -= 1
	InventoryManager.inventory_updated()
	
	if InventoryManager.swords <= 0:
		sword.disabled = true
		sword.set_pressed(false)
		current_weapon = "none"
		selected_weapon.text = "Selected Weapon: " + current_weapon
	else:
		sword.disabled = false

func use_bomb() -> void:
	for child in get_children():
		if child is Slime:
			child.update_hp(5)
	InventoryManager.bombs -= 1
	InventoryManager.inventory_updated()
	
	if InventoryManager.bombs <= 0:
		bomb.disabled = true
		bomb.set_pressed(false)
		current_weapon = "none"
		selected_weapon.text = "Selected Weapon: " + current_weapon
	else:
		bomb.disabled = false

func _on_sword_pressed() -> void:
	if bomb.button_pressed == true:
		bomb.set_pressed(false)
	
	current_weapon = "sword"
	selected_weapon.text = "Selected Weapon: " + current_weapon


func _on_bomb_pressed() -> void:
	if sword.button_pressed == true:
		sword.set_pressed(false)
	
	current_weapon = "bomb"
	selected_weapon.text = "Selected Weapon: " + current_weapon


func _on_slime_pressed() -> void:
	if current_weapon == "sword":
		use_sword(slime)
	elif current_weapon == "bomb":
		use_bomb()
		slime.set_pressed(false)
	elif current_weapon == "none":
		slime.set_pressed(false)


func _on_slime_2_pressed() -> void:
	if current_weapon == "sword":
		use_sword(slime_2)
	elif current_weapon == "bomb":
		use_bomb()
		slime.set_pressed(false)
	elif current_weapon == "none":
		slime_2.set_pressed(false)


func _on_slime_3_pressed() -> void:
	if current_weapon == "sword":
		use_sword(slime_3)
	elif current_weapon == "bomb":
		use_bomb()
		slime.set_pressed(false)
	elif current_weapon == "none":
		slime_3.set_pressed(false)
