import 'package:html_character_entities/html_character_entities.dart';

class TriviaQuestion {
  String category;
  String type;
  String difficulty;
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;
  List<String> allAnswers;

  TriviaQuestion({
    required String category,
    required String type,
    required String difficulty,
    required String question,
    required String correctAnswer,
    required List<String> incorrectAnswers,
  }) : this.incorrectAnswers = incorrectAnswers.map((answer) => HtmlCharacterEntities.decode(answer)).toList(),
       this.allAnswers = ([...incorrectAnswers, correctAnswer]..shuffle()),
       this.correctAnswer = HtmlCharacterEntities.decode(correctAnswer),
       this.question = HtmlCharacterEntities.decode(question),
       this.category = HtmlCharacterEntities.decode(category),
       this.type = HtmlCharacterEntities.decode(type),
       this.difficulty = HtmlCharacterEntities.decode(difficulty);

  factory TriviaQuestion.fromJson(Map<String, dynamic> json) {
    return TriviaQuestion(
      category: HtmlCharacterEntities.decode(json['category']),
      type: HtmlCharacterEntities.decode(json['type']),
      difficulty: HtmlCharacterEntities.decode(json['difficulty']),
      question: HtmlCharacterEntities.decode(json['question']),
      correctAnswer: HtmlCharacterEntities.decode(json['correct_answer']),
      incorrectAnswers: List<String>.from(json['incorrect_answers']).map((answer) => HtmlCharacterEntities.decode(answer)).toList(),
    );
  }
}
