extends Node

var IsOwnerTurn = true
var ActiveLittleFieldID = -1
var IsEnemyAI = false
var little_field_winners = ["-", "-", "-", "-", "-", "-", "-", "-", "-"]

var tutorial_index = 0
var winScene
var language = "ru"
var timer_time := 0.0
var StatisticsValues := [9.33, 5.71, 6.17, 8.93, -8.58, 9.43, 8.88, -5.23, 9.68, 9.65]

# Массив 9x9 для хранения состояния всех малых полей
var game_board = []

func _ready():
	winScene = get_node("/root/Core/MainGame/Win")
	# Инициализация массива: 9 малых полей, каждое с 9 клетками
	for i in range(9):
		var small_board = []
		for j in range(9):
			small_board.append("-")  # Начальное значение - пустая клетка
		game_board.append(small_board)
	
		
func update_allowed_fields(isAllGreen):
	var updatableContainer = get_node("/root/Core/MainGame/GridContainer")
	var updatableBackgr = get_node("/root/Core/MainGame/GridBackgContainer")
	is_field_occupied()
	for thing in updatableBackgr.get_children():
		if ActiveLittleFieldID < 0:
			thing.texture = preload("res://Images/Color.png")
		elif (thing.get_index() == ActiveLittleFieldID or isAllGreen or GameState.little_field_winners[ActiveLittleFieldID] == "Occupied") and (GameState.little_field_winners[thing.get_index()] == "-"):
			thing.texture = preload("res://Images/Color.png")
		else:
			thing.texture = preload("res://Images/Nothing.png")
	updatableContainer.update_display(game_board)

func is_field_occupied():
	for i in range(9):
		var count = 0
		for j in range(9):
			var field = game_board[i][j]
			if field != "-":
				count += 1
		if count == 9:
			little_field_winners[i] = "Occupied"

func ScreensOrderShuffle(core_scene, scene_name, IsAiOn:String):
	if IsAiOn == "AI":
		GameState.IsEnemyAI = true
		restart()
	elif IsAiOn == "Human":
		GameState.IsEnemyAI = false
		restart()

	GameState.tutorial_index = 0

	for scene in core_scene.get_children():
		if scene.name == scene_name:
			core_scene.move_child(scene, core_scene.get_child_count() - 1)
		if scene.name == "Stats":
			scene.get_child(1)._draw()

func restart():
	timer_time = 0.0
	var MainFields = get_node("/root/Core/MainGame/Field3x3/GridContainer")
	winScene.get_parent().move_child(winScene, 0)
	for i in range(9):
		GameState.little_field_winners[i] = "-"
		for j in range(9):
			GameState.game_board[i][j] = "-"
	GameState.IsOwnerTurn = true
	GameState.ActiveLittleFieldID = -1
	
	GameState.update_allowed_fields(MainFields.WinCheck())
	MainFields.TurnOffUnallowedFields()

func winscene_show():
	winScene.get_parent().move_child(winScene, winScene.get_parent().get_child_count() - 1)
