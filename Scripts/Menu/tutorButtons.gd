extends Node2D

var scene1 = preload("res://Scenes/Tutor/page_1.tscn")
var scene2 = preload("res://Scenes/Tutor/page_2.tscn")
var scene3 = preload("res://Scenes/Tutor/page_3.tscn")
var scene4 = preload("res://Scenes/Tutor/page_4.tscn")

var scenes = [scene1, scene2, scene3, scene4]

func _ready():
	for thing in get_children():
		for button in thing.get_children():
			if button is Button:
				if button.name == "exit":
					button.connect("pressed", func(): exit())
				elif button.name == "next":
					button.connect("pressed", func(): next())

func exit():
	for thing in self.get_children():
		if thing.name == "page1":
			self.move_child(thing, self.get_child_count())
	GameState.tutorial_index = 0
	var core_scene = get_node("/root/Core")
	GameState.ScreensOrderShuffle(core_scene, "Menu", '')

func next():	
	GameState.tutorial_index += 1
		
	for thing in self.get_children():
		if thing.name == "page" + str(GameState.tutorial_index + 1):
			self.move_child(thing, 3)
