class_name Slime
extends Button

@onready var texture_rect: TextureRect = $VBoxContainer/TextureRect
@onready var progress_bar: ProgressBar = $VBoxContainer/ProgressBar
@onready var label: Label = $VBoxContainer/Label

var hp = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_hp(0)

func update_hp(damage: int) -> void:
	hp -= damage
	
	if hp <= 0:
		hp = 0
		respawn()
	
	label.text = str(hp) + " hp"
	progress_bar.value = hp
	

func respawn() -> void:
	print("respawning slime")
	disabled = true
	await get_tree().create_timer(2.0).timeout
	texture_rect.update_region()
	hp = 10
	label.text = str(hp) + " hp"
	progress_bar.value = hp
	disabled = false
	print("slime respawned")
