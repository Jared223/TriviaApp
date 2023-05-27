import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:trivia_app/models/trivia_question.dart';
import 'dart:math';


class ApiService {
  Map<String, String> categoryToApiId = {
    'General Knowledge': '9',
    'Science': '17',
    'History': '23',
    'Geography': '22',
    'Arts': '25',
    'Books': '10', // Added 'Books' category with API code 10
    'Video Games': '15', // Added 'Video Games' category with API code 15
    'Animals': '27', // Added 'Animals' category with API code 27
    'Television': '14',
  };

  Future<List<TriviaQuestion>> fetchTriviaQuestions(String category) async {
    final randomSeed = Random().nextInt(10000); // Generate random seed
    final response = await http.get(Uri.parse('https://opentdb.com/api.php?amount=50&category=${categoryToApiId[category]}&difficulty=medium&type=multiple&seed=$randomSeed'));

    if (response.statusCode == 200) {
      return parseTriviaQuestions(response.body);
    } else {
      throw Exception('Failed to load trivia questions');
    }
  }

  List<TriviaQuestion> parseTriviaQuestions(String responseBody) {
    final parsed = jsonDecode(responseBody)["results"].cast<Map<String, dynamic>>();

    return parsed.map<TriviaQuestion>((json) => TriviaQuestion.fromJson(json)).toList();
  }
}
