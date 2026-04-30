extends Node

var quests: Array[Quest] = []

signal quest_added(quest)
signal quest_removed(quest)
signal quest_updated()

func add_quest(quest: Quest) -> void:
	quests.append(quest)
	emit_signal("quest_added", quest)
	emit_signal("quest_updated")
	print("Quest added to manager")

func remove_quest(quest: Quest) -> void:
	if quests.has(quest):
		quests.erase(quest)
		emit_signal("quest_removed", quest)
		emit_signal("quest_updated")

func update_quest(quest: Quest) -> void:
	if quests.has(quest):
		emit_signal("quest_updated")
