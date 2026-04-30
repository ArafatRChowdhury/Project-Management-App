class_name Quest

var title: String
var tasks: Array = []
var status: String = "Not Started"
var reward: int

signal task_completed
signal status_changed

#GDScript equivalent of instantiating an object
func _init(_title: String, _tasks: Array) -> void:
	title = _title
	tasks = []
	
	#tasks are stored as dictionaries in an array
	#When creating a new quest, go through the array passed in
	#and add each task in it as a dictionary, with a done value set to false
	for t in _tasks:
		tasks.append({
			"name": str(t),
			"done": false
		})
	
	reward = calculate_reward()

func calculate_reward() -> int:
	return tasks.size() * 10
	#the coins that the user gets upon quest completion depend on the number of tasks

func add_task(task_name: String) -> void:
	tasks.append({
		"name": task_name,
		"done": false
	})

func complete_task(index: int) -> void:
	#if the index is invalid, exit the function
	if index < 0 || index >= tasks.size():
		return
	
	var task = tasks[index]
	task["done"] = true
	tasks[index] = task
	update_status()
	emit_signal("task_completed")

func update_status() -> void:
	var any_completed = false
	var old_status = status
	
	#if there is nothing in tasks, the status is set to not started
	#however, users wouldn't be able to create a quest if it has no tasks
	if tasks.is_empty():
		status = "Not Started"
		return
	
	#loop through the tasks array and look for any tasks that are done
	for task in tasks:
		if not task["done"]:
			if any_completed: #if an incomplete task is found but any_completed is true
				status = "In Progress" #set the status to in progress
			else: #if any_completed is false, set it to not started
				status = "Not Started"
			return #end the function after a task is found to be incomplete
		else: #if a task is done, then set any_completed to true
			any_completed = true
	
	#if all tasks are done, set the status to completed
	status = "Completable"
	if status != old_status:
		emit_signal("status_changed")
		QuestManager.update_quest(self)

func get_progress() -> float:
	if tasks.is_empty():
		return 0.0
	
	var completed = 0
	
	for task in tasks:
		if task["done"]:
			completed += 1
	
	return float(completed) / tasks.size()
