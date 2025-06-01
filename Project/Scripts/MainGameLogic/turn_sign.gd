extends Sprite2D

func _process(_delta: float) -> void:
	if GameState.IsOwnerTurn:
		self.texture = preload("res://Images/X.png")
	else:
		self.texture = preload("res://Images/O.png")
