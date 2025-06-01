extends Control

var min_val := 0.0
var max_val := 1.0
var margin := 10
var w := 0.0
var h := 0.0

var point_labels: Array[Label] = []
var custom_font: Font
var label_settings := LabelSettings.new()

func _ready():
	# Загружаем шрифт
	var font_file: FontFile = load("res://Text/G8.otf")

	label_settings.font = font_file
	label_settings.font_size = 40                      # Размер шрифта
	label_settings.font_color = Color.WHITE             # Цвет текста

	label_settings.outline_size = 20                   # Обводка
	label_settings.outline_color = Color.BLACK

	label_settings.shadow_size = 1                      # Тень
	label_settings.shadow_color = Color(1, 1, 1, 0.5)    # Полупрозрачная белая тень
	label_settings.shadow_offset = Vector2(1.0, 1.0)


	_draw()

func _draw():
	if GameState.StatisticsValues.size() < 2:
		return

		# Создаём лейблы
	for i in range(GameState.StatisticsValues.size()):
		var label := Label.new()
		label.text = "%.2f" % GameState.StatisticsValues[i]
		label.label_settings = label_settings           # ← применяем настройки
		label.visible = false
		add_child(label)
		point_labels.append(label)


	w = size.x - 2 * margin
	h = size.y - 2 * margin

	min_val = GameState.StatisticsValues.min()
	max_val = GameState.StatisticsValues.max()

	var range = max(max_val - min_val, 0.01)
	var vertical_padding = 0.1 * range
	min_val -= vertical_padding
	max_val += vertical_padding

	var points := []
	for i in range(GameState.StatisticsValues.size()):
		points.append(value_to_point(i, GameState.StatisticsValues[i]))

	if min_val <= 0 and max_val >= 0:
		var zero_y = value_to_point(0, 0.0).y
		draw_line(Vector2(margin, zero_y), Vector2(size.x - margin, zero_y), Color.BLACK, 4)

	for i in range(points.size() - 1):
		var y0 = GameState.StatisticsValues[i]
		var y1 = GameState.StatisticsValues[i + 1]
		var color = Color.GREEN
		if y0 < 0 or y1 < 0 or (y0 <= 0 and y1 >= 0) or (y1 <= 0 and y0 >= 0):
			color = Color.RED
		draw_line(points[i], points[i + 1], color, 10)

	# точки и лейблы
	for i in range(points.size()):
		var p = points[i]
		draw_circle(p, 5, Color.DARK_BLUE)

		var label := point_labels[i]
		label.visible = true
		label.text = "%.2f" % GameState.StatisticsValues[i]
		label.position = p + Vector2(-label.size.x / 2, -20)

	draw_rect(Rect2(Vector2(margin, margin), Vector2(w, h)), Color.BLACK, false, 5)
	self.get_child(0).text = str(calculate_average())

func value_to_point(index: int, value: float) -> Vector2:
	var x = margin + (index / float(GameState.StatisticsValues.size() - 1)) * w
	var y = margin + h * (1.0 - (value - min_val) / (max_val - min_val))
	return Vector2(x, y)


func calculate_average() -> float:
	if GameState.StatisticsValues.is_empty():
		return 0.0
	
	var total := 0.0
	for value in GameState.StatisticsValues:
		total += value
	
	var avg := total / GameState.StatisticsValues.size()
	return round(avg * 100.0) / 100.0  # Округление до двух знаков
