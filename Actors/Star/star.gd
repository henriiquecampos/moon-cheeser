extends "res://Actors/abstract_space_body.gd"

func _ready():
	#get_node("Sprite").set_texture(load(skins.star_skin))
	pass

func _instance_starmouse(collider):
	if get_tree().get_nodes_in_group("starmouse").size() == 0:
		var i = load("res://Actors/Astromouse/StarMouse.tscn").instance()
		i.set_pos(get_pos())
		get_parent().add_child(i)
		collider.queue_free()