extends Control

var player_words = []
var template = [
	{
		"prompts": ["a name", "a noun", "an adverd", "an adjective"],
		"story": "Once upon a time someone called %s ate a %s flavoured sandwich which made him feel all %s inside. It was %s day."
	},
	{
		"prompts": ["a name", "an adjective", "an adverd", "a noun"],
		"story": "There was once a warrior named  %s. %s they said he was, he fought %s , which granted him the people's %s "
	}
]

var current_story 

onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText
onready var DisplayText = $VBoxContainer/DisplayText

func _ready():
	DisplayText.text = "Welcome to Loony Lips! We're going to tell a story and have a wonderful time! \n \n"
	#print(story % prompts)
	#DisplayText.text = story % prompts
	check_player_words_length()
	PlayerText.grab_focus()

func _on_PlayerText_text_entered(new_text):
	add_to_player_words()
	#update_DisplayText(new_text)
	#story = ""

func _on_TextureButton_pressed():
	#var currentText = PlayerText.text
	#update_DisplayText(currentText)
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		add_to_player_words()
		

func update_DisplayText(words):
	#$VBoxContainer/DisplayText.text = words
	#$VBoxContainer/HBoxContainer/PlayerText.clear()
	#print(words)
	pass


func add_to_player_words():
	if (player_words.size() == 3):
		PlayerText.text = add_adjective_preffix(PlayerText.text)
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
