extends Window

@onready var quest_name: LineEdit = $Control/ColorRect/VBoxContainer/QuestNameEdit
@onready var v_box_container: VBoxContainer = $Control/ColorRect/VBoxContainer/ScrollContainer/VBoxContainer
@onready var add_task_button: Button = $Control/ColorRect/VBoxContainer/AddTaskButton
@onready var reward: Label = $Control/ColorRect/RewardLabel
@onready var line_edit_1: LineEdit = $Control/ColorRect/VBoxContainer/ScrollContainer/VBoxContainer/LineEdit
@onready var line_edit_2: LineEdit = $Control/ColorRect/VBoxContainer/ScrollContainer/VBoxContainer/LineEdit2
@onready var line_edit_3: LineEdit = $Control/ColorRect/VBoxContainer/ScrollContainer/VBoxContainer/LineEdit3
@onready var create_quest_button: Button = $Control/ColorRect/CreateQuestButton

signal quest_created(quest)

func _process(delta: float) -> void:
	display_reward()

func display_reward() -> void:
	var count = 0
	
	#go through all the children of v_box_container
	for child in v_box_container.get_children():
		#if it's not a LineEdit with text in it, ignore it
		#if it is, increase the count by 1
		if child is LineEdit && child.text.strip_edges() != "":
			count += 1
	
	#the coins given is equal to number of quests multiplied by 10
	var coins = count * 10
	#update the text
	reward.text = "Reward: " + str(coins) + " Coins"

func _on_add_task_button_pressed() -> void:
	#add a new LineEdit to v_box_container
	var line_edit = LineEdit.new()
	line_edit.placeholder_text = "Task"
	
	#update reward
	line_edit.text_changed.connect(func(_text):
		display_reward()
	)
	
	v_box_container.add_child(line_edit)
	display_reward()

func _on_create_quest_button_pressed() -> void:
	#add all the text values of the v_box_container to an array
	#create a new instance of a quest object, with the quest_name as the name
	#and the array as tasks
	#emit the quest_created signal for the Quest Manager
	var title = quest_name.text.strip_edges()
	var tasks: Array = []
	var quest
	
	if title == "":
		return
	
	for child in v_box_container.get_children():
		if child is LineEdit:
			var text = child.text.strip_edges()
			if text != "":
				tasks.append(text)
	
	if tasks.is_empty():
		return
	
	quest = Quest.new(title, tasks)
	emit_signal("quest_created", quest)
	QuestManager.add_quest(quest)
	print("NEW QUEST TASKS:")
	for t in quest.tasks:
		print(t)
	reset_form()
	hide()

func reset_form():
	quest_name.text = ""
	
	for child in v_box_container.get_children():
		if child is LineEdit:
			child.text = ""

func _on_close_requested() -> void:
	reset_form()
	hide()
