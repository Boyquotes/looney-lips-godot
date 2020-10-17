extends Control

var player_words = []
#var template = [
#	{
#		"prompts": ["a name", "a noun", "an adverd", "an adjective"],
#		"story": "Once upon a time someone called %s ate a %s flavoured sandwich which made him feel all %s inside. It was %s day."
#	},
#	{
#		"prompts": ["a name", "an adjective", "an adverd", "a noun"],
#		"story": "There was once a warrior named  %s. %s they said he was, he fought %s , which granted him the people's %s "
#	},
#		{
#		"prompts": ["a name", "a thing", "a feeling", "another feeling", "some things"],
#		"story": "Once upon a time a %s ate a %s and felt very %s. It was a %s day for all good %s.]"
#	},
#	{
#		"prompts": ["a noun", "a name", "an adjective", "another name"],
#		"story": "There once was %s called %s who searched far and wide for the mythical %s of %s."
#	},
#	{
#		"prompts": ["a thing", "an name", "a description word (an adjective)", "a thing"],
#		"story": "There was once %s called %s that lived as %s as a %s."
#	}
#]

var current_story = {}

onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText
onready var DisplayText = $VBoxContainer/DisplayText

func _ready():
	set_current_story()
	DisplayText.text = "Welcome to Loony Lips! We're going to tell a story and have a wonderful time! \n \n"

	check_player_words_length()
	PlayerText.grab_focus()

func set_current_story():
	randomize()
	var stories = $StoryBook.get_child_count()
	var selected_story_number = randi() % stories
	current_story.prompts = $StoryBook.get_child(selected_story_number).prompts
	current_story.story = $StoryBook.get_child(selected_story_number).story
	# current_story = template[randi() % template.size()]
	
func _on_PlayerText_text_entered(_new_text):
	add_to_player_words()

func _on_TextureButton_pressed():
	if is_story_done():
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
	else:
		add_to_player_words()
		

func update_DisplayText(_words):
	#$VBoxContainer/DisplayText.text = words
	#$VBoxContainer/HBoxContainer/PlayerText.clear()
	#print(words)
	pass


func add_to_player_words():
#	if (player_words.size() == 3):
#		PlayerText.text = add_adjective_preffix(PlayerText.text)
	DisplayText.text = ""
	player_words.append(PlayerText.text)
	PlayerText.clear()
	check_player_words_length()

func is_story_done():
	return player_words.size() == current_story.prompts.size()

func check_player_words_length():
	if is_story_done():
		end_game()
	else: 
		prompt_player()
		
		
func tell_story():
	DisplayText.text = current_story.story % player_words
	
func prompt_player():
	DisplayText.text += "May I have " + current_story.prompts[player_words.size()] + " please?"
	
func end_game():
	PlayerText.queue_free()
	$VBoxContainer/HBoxContainer/TextureButton/Label.text = "Again"
	tell_story()
	
func add_adjective_preffix(txt):
	var vowels = ["a", "e", "h", "i", "o", "u", "w", "y"]
	if txt[0] in vowels:
		txt = "an " + txt
	else:
		txt = "a " + txt
	return txt
