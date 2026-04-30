extends Node

var coins: int = 500

signal coins_changed(new_amount)

func add_coins(amount: int):
	coins += amount
	emit_signal("coins_changed", coins)

func remove_coins(amount: int):
	coins -= amount
	emit_signal("coins_changed", coins)
