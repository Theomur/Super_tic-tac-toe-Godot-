extends Node2D

func _ready():
	var children = self.get_children()
	
	if self.name == "LittleField3x3":
		for j in range(9):
			var button = self.get_child(0).get_child(j)
			match GameState.game_board[GameState.ActiveLittleFieldID][j]:
				"X":
					button.icon = preload("res://Images/X.png")
				"O":
					button.icon = preload("res://Images/O.png")
				"-":
					button.icon = preload("res://Images/Nothing.png")

	for i in len(children):
		var thing = children[i]
		if thing is Button:
			# Подключаем сигнал с передачей индекса кнопки
			thing.connect("pressed", func(): queue_free())
		if thing is GridContainer:
			var buttons = thing.get_children()
			for j in len(buttons):
				var button = buttons[j]
				button.connect("pressed", func(): LittleField_Popup(j, self.get_parent()))

func LittleField_Popup(LittleFieldIndex, PopupScene):
	var MainFields = get_node("/root/Core/MainGame/Field3x3/GridContainer")
	var AI_agent = get_node("/root/Core/MainGame/AI_Moves")
	var thing = "X"
	if GameState.IsOwnerTurn == false:
		thing = "O"
	if GameState.game_board[GameState.ActiveLittleFieldID][LittleFieldIndex] == "-":
		GameState.game_board[GameState.ActiveLittleFieldID][LittleFieldIndex] = thing
		GameState.ActiveLittleFieldID = LittleFieldIndex
		GameState.update_allowed_fields(MainFields.WinCheck())
		if GameState.IsEnemyAI:
			AI_agent.AiTurn()
		else:
			GameState.IsOwnerTurn = !GameState.IsOwnerTurn
		GameState.update_allowed_fields(MainFields.WinCheck())
		MainFields.TurnOffUnallowedFields()
		PopupScene.queue_free()
