class_name QuestUI
extends Control

@onready var quest_creation: Window = $ColorRect/QuestCreation
@onready var quest_list: VBoxContainer = $ColorRect/ScrollContainer/QuestList

const QUEST_ITEM = preload("uid://c6rwrjx5jy21b")

func _ready() -> void:
	quest_creation.hide()
	quest_creation.quest_created.connect(func(_quest):
		refresh_quests()
	)
	refresh_quests()
	QuestManager.quest_added.connect(refresh_quests)

func refresh_quests(_quest = null) -> void:
	for child in quest_list.get_children():
		child.queue_free()
	
	print("Loading: " + str(QuestManager.quests.size()) + " Quests")
	
	for quest in QuestManager.quests:
		if quest.status != "Completed":
			var item = QUEST_ITEM.instantiate()
			item.setup(quest)
			quest_list.add_child(item)
	

func on_quest_created(quest: Quest) -> void:
	QuestManager.add_quest(quest)
	quest_creation.hide()

func _on_add_quest_pressed() -> void:
	quest_creation.show()

func _on_quest_creation_close_requested() -> void:
	quest_creation.hide()
