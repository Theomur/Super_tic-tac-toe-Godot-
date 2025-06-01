extends GridContainer

func update_display(field_data: Array):
	var fields = get_children()
	for i in range(9):
		var field = fields[i]
		for j in range(9):
			var button = field.get_children()[0].get_children()[j]
			match field_data[i][j]:
				"X":
					button.icon = preload("res://Images/X.png")
				"O":
					button.icon = preload("res://Images/O.png")
				"-":
					button.icon = preload("res://Images/Nothing.png")
