class_name Question extends Resource

@export var content: Content
@export var choices: Array[String]
@export var right_choice: Choices
@export_range(5, 60) var time = 10.0

enum Choices {Left, Right}
