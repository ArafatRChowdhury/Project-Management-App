extends Control

@onready var not_started: VBoxContainer = $ColorRect/VBoxContainer/HBoxContainer/Panel/ScrollContainer/NotStarted
@onready var in_progress: VBoxContainer = $ColorRect/VBoxContainer/HBoxContainer/Panel2/ScrollContainer/InProgress
@onready var completed: VBoxContainer = $ColorRect/VBoxContainer/HBoxContainer/Panel3/ScrollContainer/Completed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	QuestManager.quest_updated.connect(organise_quests)
	organise_quests()

func organise_quests() -> void:
	#Queue free all the children in each column
	for child in not_started.get_children():
		child.queue_free()
	for child in in_progress.get_children():
		child.queue_free()
	for child in completed.get_children():
		child.queue_free()
	
	#for each quest, organise them into the correct column depending on progress status
	for quest in QuestManager.quests:
		var newLabel = Label.new()
		newLabel.text = quest.title
		newLabel.set("theme_override_colors/font_color", Color("000000ff"))
		
		if quest.status == "Not Started":
			not_started.add_child(newLabel)
		if quest.status == "In Progress" || quest.status == "Completable":
			in_progress.add_child(newLabel)
		if quest.status == "Completed":
			completed.add_child(newLabel)
