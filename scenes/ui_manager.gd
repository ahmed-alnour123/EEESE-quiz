extends CanvasLayer

var text_conetnt
var video_content
var image_content

func _ready() -> void:
	text_conetnt = $Question/Padding/PanelContainer/Padding/Column/content/TextContent
	image_content = $Question/Padding/PanelContainer/Padding/Column/content/ImageContent
	video_content = $Question/Padding/PanelContainer/Padding/Column/content/VideoContent

func set_content(new_content):
	# 1- hide all nodes
	# 2- set up required node
	# 3- show the node
	for c in [text_conetnt, image_content, video_content]:
		c.hide()
		
	if new_content is TextContent:
		text_conetnt.text = new_content.content
		text_conetnt.show()
	elif new_content is ImageContent:
		image_content.texture = new_content.content
		image_content.show()
	elif new_content is VideoContent:
		var video_node = video_content.get_node("VideoStreamPlayer")
		video_node.stream = new_content.content
		video_content.show()
		video_node.play()
		
	else:
		printerr("Unknown content type, go check it man")
		
func set_choices(new_choice):
	$Question/Padding/PanelContainer/Padding/Column/ButtonRow/Choice1/TextChoice.text = new_choice[0]
	$Question/Padding/PanelContainer/Padding/Column/ButtonRow/Choice2/TextChoice.text = new_choice[1]
	
func play_show_animation(show = true):
	$Question.modulate = Color.TRANSPARENT if show else Color.WHITE
	var tween = get_tree().create_tween()
	tween.tween_property($Question, "modulate", Color.WHITE if show else Color.TRANSPARENT, 0.5)

func update_timer(value: float):
	$ProgressBar.value = value
	
