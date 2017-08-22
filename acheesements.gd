extends Node

var dict = {}
export (String, FILE) var file_path
var file = File.new()
var text

onready var popup = get_node("Popup")
onready var timer = get_node("Timer")
onready var tween = get_node("Tween")

func _ready():
	var t = Translation.new()
	t.set_locale("pt_BR")
	print(file_path)
	read_achievements()

func read_achievements():
	if file.file_exists("user://achievements.json"):
		file.open("user://achievements.json", file.READ)
		text = file.get_as_text()
		dict.parse_json(text)
		file.close()
	else:
		file.open(file_path, file.READ)
		text = file.get_as_text()
		dict.parse_json(text)
		file.close()
		file.open("user://achievements.json", file.WRITE)
		write_achievements()
		file.close()

func write_achievements():
	if file.file_exists("user://achievements.json"):
		file.open("user://achievements.json", file.WRITE)
		file.store_string(dict.to_json())
		file.close()
	skins.write_skins()

func modify_achievement(achievement, value):
	if value == 0:
		dict[achievement].accomplished = 0
	if dict[achievement].accomplished < dict[achievement].total: 
		dict[achievement].accomplished += value
		if dict[achievement].accomplished >= dict[achievement].total: 
			popup.set_title("Acheesement unlocked!")
			popup.set_text(dict[achievement].name)
			_show_popup()

func _on_timeout():
	_hide_popup()

func _show_popup():
	popup.popup()
	tween.interpolate_property(popup, "rect/pos", popup.get_pos(), popup.get_pos() + Vector2(0, 100),
	0.5, tween.TRANS_BACK, tween.EASE_OUT)
	tween.start()
	timer.start()
	
func _hide_popup():
	tween.interpolate_property(popup, "rect/pos", popup.get_pos(), popup.get_pos() - Vector2(0, 100),
	0.5, tween.TRANS_BACK, tween.EASE_IN)
	tween.start()
	yield(tween, "tween_complete")
	popup.hide()