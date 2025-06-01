extends Control

var core_scene

func _ready() -> void:
	core_scene = get_node("/root/Core")
	for button in self.get_children():
		if button is Button:
			if button.name == "StartAI":
				button.connect("pressed", func(): GameState.ScreensOrderShuffle(core_scene, "MainGame", 'AI'))
			if button.name == "StartHuman":
				button.connect("pressed", func(): GameState.ScreensOrderShuffle(core_scene, "MainGame", 'Human'))
			if button.name == "Stats":
				button.connect("pressed", func(): GameState.ScreensOrderShuffle(core_scene, "Stats", ''))
			if button.name == "Tutorial":
				button.connect("pressed", func(): GameState.ScreensOrderShuffle(core_scene, "Tutorial", ''))
