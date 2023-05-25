import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:trivia_app/models/trivia_question.dart'; // Import the TriviaQuestion class

class ApiService {
  Map<String, String> categoryToApiId = {
    'General Knowledge': '9',
    'Science': '17',
    'History': '23',
    'Geography': '22',
    'Arts': '25',
  };

  Future<List<TriviaQuestion>> fetchTriviaQuestions(String category) async {
    final response = await http.get(Uri.parse('https://opentdb.com/api.php?amount=50&category=${categoryToApiId[category]}&difficulty=medium&type=multiple'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response,
      // then parse the JSON.
      return parseTriviaQuestions(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load trivia questions');
    }
  }

  List<TriviaQuestion> parseTriviaQuestions(String responseBody) {
    final parsed = jsonDecode(responseBody)["results"].cast<Map<String, dynamic>>();

    return parsed.map<TriviaQuestion>((json) => TriviaQuestion.fromJson(json)).toList();
  }
}
