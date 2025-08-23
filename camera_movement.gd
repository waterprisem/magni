extends Camera2D
@export var target: Node2D

func _process(_delta):
	self.position = Vector2(position.x, target.position.y)
