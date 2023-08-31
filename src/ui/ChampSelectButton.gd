extends Button

signal _champSelect(name : StringName)
func _on_pressed():
	emit_signal("_champSelect", self.name)
