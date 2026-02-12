extends Button

signal question_clicked(reward, questionText, alt1, alt2, alt3, correctAnswer)

var questionText: String
var alt1: String
var alt2: String
var alt3: String
var correctAnswer: int
var reward: int

func setData(score: int, questionData: Dictionary):
	text = str(score)
	
	reward = score
	questionText = questionData["question"]
	alt1 = questionData["alt1"]
	alt2 = questionData["alt2"]
	alt3 = questionData["alt3"]
	correctAnswer = questionData["correctAlt"]
	if questionText.is_empty():
		print("Missing question with reward ", reward)

func _on_button_pressed() -> void:
	if GlobalData.question_open:
		return
	question_clicked.emit(reward, questionText, alt1, alt2, alt3, correctAnswer)
	disabled = true
