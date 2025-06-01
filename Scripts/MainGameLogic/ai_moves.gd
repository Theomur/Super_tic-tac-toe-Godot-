extends Node2D


# логика бота
func AiTurn():
	var player_symbol = "O"
	var opponent_symbol = "X"
	var best_score = -INF
	var best_move = null

	var allowed_boards = get_allowed_boards(GameState.little_field_winners, GameState.ActiveLittleFieldID)

	for board_idx in allowed_boards:
		var board = GameState.game_board[board_idx]
		for cell_idx in range(9):
			if board[cell_idx] == "-":
				# Копируем текущие состояния
				var temp_board = board.duplicate()
				var temp_winners = GameState.little_field_winners.duplicate()
				var temp_game_board = GameState.game_board.duplicate()

				# Применяем ход
				temp_board[cell_idx] = player_symbol
				temp_game_board[board_idx] = temp_board
				temp_winners[board_idx] = check_winner(temp_board)

				# Оцениваем ход
				var score = evaluate_move(temp_game_board, temp_winners, board_idx, cell_idx, player_symbol, opponent_symbol)

				if score > best_score:
					best_score = score
					best_move = {
						"board_idx": board_idx,
						"cell_idx": cell_idx
					}

	if best_move != null:
		# Применяем лучший ход
		GameState.game_board[best_move.board_idx][best_move.cell_idx] = player_symbol
		GameState.little_field_winners[best_move.board_idx] = check_winner(GameState.game_board[best_move.board_idx])
		GameState.ActiveLittleFieldID = best_move.cell_idx


func get_allowed_boards(winners: Array, active_board: int) -> Array:
	if active_board >= 0 and winners[active_board] == "-":
		return [active_board]
	else:
		var boards = []
		for i in range(9):
			if winners[i] == "-":
				boards.append(i)
		return boards

func check_winner(cells: Array) -> String:
	var win_patterns = [
		[0, 1, 2],
		[3, 4, 5],
		[6, 7, 8],
		[0, 3, 6],
		[1, 4, 7],
		[2, 5, 8],
		[0, 4, 8],
		[2, 4, 6]
	]
	for pattern in win_patterns:
		var a = cells[pattern[0]]
		if a != "-" and a == cells[pattern[1]] and a == cells[pattern[2]]:
			return a
	return "-"

func evaluate_move(all_boards: Array, winners: Array, board_idx: int, cell_idx: int, player_symbol: String, opponent_symbol: String) -> int:
	var score = 0
	var board = all_boards[board_idx]

	# Проверка на победу в поддоске
	if check_winner(board) == player_symbol:
		score += 1000

	# Блокировка победы противника
	board[cell_idx] = opponent_symbol
	if check_winner(board) == opponent_symbol:
		score += 500
	board[cell_idx] = player_symbol  # Возвращаем значение

	# Центральные позиции
	if board_idx == 4:
		score += 50
	if cell_idx == 4:
		score += 30

	# Проверка на победу в основной доске
	var temp_winners = winners.duplicate()
	temp_winners[board_idx] = check_winner(board)
	if check_winner(temp_winners) == player_symbol:
		score += 10000

	return score
