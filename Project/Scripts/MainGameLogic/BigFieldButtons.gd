extends GridContainer

var popup_scene = preload("res://Scenes/Game/Popup.tscn")
func _ready():
	# Подключаем сигналы для всех кнопок в GridContainer
	for i in range(9):
		var button = self.get_child(i)
		# Подключаем сигнал с передачей индекса кнопки
		button.connect("pressed", func(): _on_little_field_pressed(i))

func _on_little_field_pressed(index: int):
	var popup_instance = popup_scene.instantiate()
	# Записываем ID активного малого поля в GameState
	GameState.ActiveLittleFieldID = index
	# Открываем сцену Popup
	get_parent().add_child(popup_instance)

func TurnOffUnallowedFields():
	var allowed_field = GameState.ActiveLittleFieldID
	for i in self.get_child_count():
		var button = self.get_child(i)
		if allowed_field < 0 or i == allowed_field or GameState.little_field_winners[allowed_field] != "-":
			button.button_mask = MOUSE_BUTTON_MASK_LEFT
		else:
			button.button_mask = 0
		if get_winner(GameState.little_field_winners) != '-':
			button.button_mask = 0
			
			

func WinCheck():
	for field_index in range(9):
		var board = GameState.game_board[field_index]
		var winner = get_winner(board)
		GameState.little_field_winners[field_index] = winner
		var MainFields = get_node("/root/Core/MainGame/Field3x3/GridContainer")
		if winner == 'X':
			MainFields.get_child(field_index).icon = preload("res://Images/X.png")
		elif winner == 'O':
			MainFields.get_child(field_index).icon = preload("res://Images/O.png")
		else:
			MainFields.get_child(field_index).icon = preload("res://Images/Nothing.png")

	var big_winner = get_winner(GameState.little_field_winners)
	if big_winner == 'X':
		GameState.winScene.get_child(0).get_child(0).texture = preload("res://Images/X.png")
		GameState.winscene_show()
		for i in range(1, GameState.StatisticsValues[len(GameState.StatisticsValues) - 1]):
			GameState.StatisticsValues[i-1] = GameState.StatisticsValues[i]
		GameState.StatisticsValues[len(GameState.StatisticsValues) - 1] = GameState.timer_time / 10
	elif big_winner == 'O':
		GameState.winScene.get_child(0).get_child(0).texture = preload("res://Images/O.png")
		GameState.winscene_show()
		for i in range(1, GameState.StatisticsValues[len(GameState.StatisticsValues) - 1]):
			GameState.StatisticsValues[i-1] = GameState.StatisticsValues[i]
		GameState.StatisticsValues[len(GameState.StatisticsValues) - 1] = GameState.timer_time / 10

	return GameState.little_field_winners[GameState.ActiveLittleFieldID] != "-"

func get_winner(board: Array) -> String:
	var lines = [
		# Горизонтали
		[0, 1, 2],
		[3, 4, 5],
		[6, 7, 8],
		# Вертикали
		[0, 3, 6],
		[1, 4, 7],
		[2, 5, 8],
		# Диагонали
		[0, 4, 8],
		[2, 4, 6],
	]

	for line in lines:
		var a = board[line[0]]
		var b = board[line[1]]
		var c = board[line[2]]
		if a != "-" and a == b and b == c:
			return a

	return "-"
