import 'package:flutter/material.dart';
import '../models/trivia_question.dart';
import 'package:trivia_app/services/api_service.dart';
import 'package:html_character_entities/html_character_entities.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  ApiService _apiService = ApiService();
  List<TriviaQuestion> _questions = [];

  @override
  void initState() {
    super.initState();
    _loadTriviaQuestions();
  }

  _loadTriviaQuestions() async {
    _questions = await _apiService.fetchTriviaQuestions();
    for (var question in _questions){
      question.question = HtmlCharacterEntities.decode(question.question);
    }
    setState(() {}); // Calls build() to refresh the UI with new questions
  }

  @override
Widget build(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage('https://images.unsplash.com/photo-1579546929662-711aa81148cf'), // replace with your image URL
      ),
    ),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      body: _questions.isEmpty
          ? CircularProgressIndicator() // Display a loading indicator
          : ListView.builder(
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_questions[index].question),
                  // Add more UI elements as per design
                );
              },
            ),
    ),
  );
}


}
