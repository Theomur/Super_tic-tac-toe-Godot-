extends Button

func _ready():
	if self.name == "Exit":
		self.connect("pressed", func(): exit())
	elif self.name == "Restart":
		self.connect("pressed", func(): GameState.restart())

func exit():
	var core_scene = get_node("/root/Core")
	GameState.ScreensOrderShuffle(core_scene, "Menu", '')
