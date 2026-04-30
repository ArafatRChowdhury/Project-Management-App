extends PanelContainer

var quest: Quest

@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var quest_name: Label = $VBoxContainer/QuestName
@onready var tasklist: VBoxContainer = $VBoxContainer/ScrollContainer/Tasklist
@onready var progress_bar: ProgressBar = $VBoxContainer/ProgressBar
@onready var button: Button = $VBoxContainer/Button
@onready var coins: Label = $VBoxContainer/Coins

func _ready():
	if quest:
		quest_name.text = quest.title
		update_ui()

func setup(newQuest: Quest):
	quest = newQuest
	if quest_name:
		quest_name.text = quest.title
	else:
		print("Null quest name")
	
	if is_inside_tree():
		_apply_data()
	else:
		call_deferred("_apply_data")

func _apply_data() -> void:
	coins.text = "Reward: " + str(quest.reward) + " Coins"
	update_ui()

func update_ui():
	progress_bar.value = quest.get_progress() * 100
	
	if quest.status == "Completable":
		button.disabled = false
	else:
		button.disabled = true
	
	for child in tasklist.get_children():
		child.queue_free()
	
	for i in range(quest.tasks.size()):
		var task = quest.tasks[i]
		var checkbox = CheckBox.new()
		var index = i
		checkbox.text = task["name"]
		checkbox.button_pressed = task["done"]
		
		if task["done"]:
			checkbox.add_theme_color_override("font_color", Color.GRAY)
		
		checkbox.toggled.connect(func(pressed):
			quest.tasks[index]["done"] = pressed
			quest.update_status()
			QuestManager.update_quest(quest)
			
			progress_bar.value = quest.get_progress() * 100
			
			if quest.status == "Completable":
				button.disabled = false
			else:
				button.disabled = true
		)
		
		tasklist.add_child(checkbox)
	


func _on_button_pressed() -> void:
	CoinManager.add_coins(quest.reward)
	quest.status = "Completed"
	QuestManager.update_quest(quest)
	print("Current coins: " + str(CoinManager.coins))
	queue_free()
