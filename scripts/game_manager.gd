extends Node2D

@export_group("Setup")
@export var left_color: Color
@export var right_color: Color

@export_group("Questions")
@export var questions: Array[Question]

var current_index = 0
var ui_manager
var is_question_showing = false
var question_time: float = 10.0
var timer

func _ready() -> void:
	ui_manager = $UI
	
func _process(delta: float) -> void:
	# don't read input when question is showing, hide question with a timer
	if not is_question_showing:
		if Input.is_action_just_pressed("next_question"):
			# if we ran out of questions, end game
			if current_index >= questions.size():
				return
			set_question_panel(questions[current_index])
			current_index += 1
		if Input.is_action_just_pressed("team1_forward"):
			$Player1.move_forward()
		if Input.is_action_just_pressed("team2_forward"):
			$Player2.move_forward()
		if Input.is_action_just_pressed("team3_forward"):
			$Player3.move_forward()
	else:
		$UI.update_timer(timer.get_time_left() * 100/ question_time)
			

func set_question_panel(q: Question):
	is_question_showing = true
	question_time = q.time
	ui_manager.show()
	ui_manager.play_show_animation()
	ui_manager.set_content(q.content)
	ui_manager.set_choices(q.choices)
	timer = get_tree().create_timer(question_time)
	timer.connect("timeout", hide_questions_panel)
	
func hide_questions_panel():
	ui_manager.hide()
	is_question_showing = false
