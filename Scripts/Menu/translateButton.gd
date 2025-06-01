extends Button

var core_scene
var labels := []

func _ready() -> void:
	core_scene = get_node("/root/Core")
	self.connect("pressed", func(): change_lang())

	# Рекурсивно собираем все Label-узлы
	labels = get_tree().get_root().find_children("*", "Label", true, false)

func change_lang():
	if GameState.language == 'en':
		GameState.language = 'ru'
		for label in labels:
			match label.name:
				"Label":
					label.text = 'Супер \nКрестики-Нолики'
				"StartAI":
					label.text = 'Начать\nигру с ИИ'
				"StartHuman":
					label.text = 'Начать\nигру с другом'
				"switchToLan":
					label.text = 'Switch to\nEnglish language'
				"Tutorial":
					label.text = 'Обучение'
				"Stats":
					label.text = 'Статистика'
				"Turn lable":
					label.text = 'Сейчас ходит:'
				"TutrPage4":
					label.text = 'Если вам, или оппоненту \nнеобходимо ходить в клетке, \nуже занятой игроком - то можно \nпоходить в любой \nсвободной клетке\n\nПобедившим считается игрок,\nкоторый смог выстроить 3 своих \nзнака в ряд (как в обычной \nигре в крестики-нолики)'
				"TutrPage3":
					label.text = 'Если игрок побеждает в маленькой \nигре - за ним закрепляется победа \nв большой игре'
				"TutrPage2-1":
					label.text = 'Правила хода\nПервый игрок может поставить \nсвой знак в любую клетку любого \nмаленького поля.\n\nСледующий игрок должен ходить \nв то маленькое поле, которое \nсоответствует относительной \nпозиции клетки, куда \nбыл сделан предыдущий ход.\nНапример:'
				"TutrPage2-2":
					label.text = '(Зеленым помечается поле, \nв котором нужно походить \nследующему игроку)'
				"TutrPage1":
					label.text = 'Цель игры - Как и в обычных \nкрестиках-ноликах: собрать 3 \nвыигранных маленьких поля \nв ряд (по горизонтали, \nвертикали или диагонали) \nв большом поле.\n\nСупер Крестики-Нолики состоит из:\n9 маленьких полей (3×3)\nОбъединённых в одно большое \nполе (3×3 из маленьких)'
				"PressToGo":
					label.text = 'Нажми в центр чтобы \nперейти дальше'
				"PressToExit":
					label.text = 'Нажми на кнопку выхода,\nчтобы выйти'
				"Average":
					label.text = 'Среднее:'
				

	elif GameState.language == 'ru':
		GameState.language = 'en'
		for label in labels:
			match label.name:
				"Label":
					label.text = 'Super\nTic-Tac-Toe'
				"StartAI":
					label.text = 'Play vs\nAI'
				"StartHuman":
					label.text = 'Play vs\nFriend'
				"switchToLan":
					label.text = 'Сменить язык\nна русский'
				"Tutorial":
					label.text = 'Tutorial'
				"Stats":
					label.text = 'Statistics'
				"Turn lable":
					label.text = 'Now playing:'
				"TutrPage4":
					label.text = 'If you or your opponent\nmust play in a field\nthat is already won,\nyou can play\nin any free cell\n\nThe winner is the player\nwho lines up 3 of their\nsymbols in a row\n(as in classic tic-tac-toe)'
				"TutrPage3":
					label.text = 'If a player wins a small\ngame, that win counts\non the big board'
				"TutrPage2-1":
					label.text = 'Turn rules\nFirst player can choose\nany cell in any small board.\n\nThe next player must move\nin the small board that matches\nthe relative position\nof the previous move.\nExample:'
				"TutrPage2-2":
					label.text = '(The field where the\nnext move must be made\nis highlighted in green)'
				"TutrPage1":
					label.text = 'Goal: As in classic\nTic-Tac-Toe — align 3\nwon small boards in a row\n(horizontal, vertical,\nor diagonal) on the big board.\n\nSuper Tic-Tac-Toe consists of:\n9 small boards (3×3)\nGrouped into one big\nboard (3×3 of small boards)'
				"PressToGo":
					label.text = 'Click the center\nto continue'
				"PressToExit":
					label.text = 'Click Exit button\n to exit'
				"Average":
					label.text = 'Average:'
