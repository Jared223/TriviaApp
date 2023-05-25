import 'package:flutter/material.dart';
import '../models/trivia_question.dart';
import 'package:trivia_app/services/api_service.dart';

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
    setState(() {}); // Calls build() to refresh the UI with new questions
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
