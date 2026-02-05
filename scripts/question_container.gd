extends PanelContainer

signal correct_answer(team: int, score: int)
signal wrong_answer(team: int, score:int)
signal close_popup_question()

var correctOption: int
var reward: int

#TODO: Add time limit? Or other way to close a question

func setQuestionData(score, questionText, alt1, alt2, alt3, correctAnswer):
	reward = score
	$QuestionBox/QuestionTextContainer/QuestionText.text = questionText
	$QuestionBox/OptionsList/Option1.text = alt1
	$QuestionBox/OptionsList/Option2.text = alt2
	$QuestionBox/OptionsList/Option3.text = alt3
	correctOption = correctAnswer

func closeQuestion():
	close_popup_question.emit()
	queue_free()

func correctAnswer():
	correct_answer.emit(GlobalData.currentTeam, reward)
	closeQuestion()

func wrongAnswer(buttonNumber):
	wrong_answer.emit(GlobalData.currentTeam, reward/2)
	get_node("QuestionBox/OptionsList/Option%d" %buttonNumber).disabled = true
	# lose half reward

func _on_option_1_pressed() -> void:
	if correctOption != 1:
		wrongAnswer(1)
		return
	correctAnswer()
	print("Pressed 1")


func _on_option_2_pressed() -> void:
	if correctOption != 2:
		wrongAnswer(2)
		return
	correctAnswer()
	print("Pressed 2")


func _on_option_3_pressed() -> void:
	if correctOption != 3:
		wrongAnswer(3)
		return
	correctAnswer()
	
	print("Pressed 3")
