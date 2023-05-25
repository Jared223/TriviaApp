import 'package:flutter/material.dart';
import '../models/trivia_question.dart';
import 'package:trivia_app/services/api_service.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'GameOverScreen.dart'; // Import the GameOverScreen widget

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  ApiService _apiService = ApiService();
  List<TriviaQuestion> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _gameEnded = false;

  @override
  void initState() {
    super.initState();
    _loadTriviaQuestions();
  }

  _loadTriviaQuestions() async {
    _questions = await _apiService.fetchTriviaQuestions();
    for (var question in _questions) {
      question.question = HtmlCharacterEntities.decode(question.question);
    }
    setState(() {}); // Calls build() to refresh the UI with new questions
  }

  _checkAnswer(String selectedAnswer) {
    if (_questions[_currentQuestionIndex].correctAnswer == selectedAnswer) {
      _score++;
      // Display some kind of success message
    } else {
      _gameEnded = true;
      // Display some kind of failure message
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GameOverScreen(
            score: _score,
            onTryAgain: () {
              // Reset the game and start a new game
            },
            onBackToMenu: () {
              // Navigate back to the menu
              Navigator.pop(context);
            },
          ),
        ),
      );
    }
    if (!_gameEnded && _currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_gameEnded) {
      return Scaffold(
        // Display a game over screen with the final score
        body: GameOverScreen(
          score: _score,
          onTryAgain: () {
            // Reset the game and start a new game
          },
          onBackToMenu: () {
            // Navigate back to the menu
            Navigator.pop(context);
          },
        ),
      );
    } else if (_questions.isEmpty) {
      return CircularProgressIndicator(); // Display a loading indicator
    } else {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1579546929662-711aa81148cf'), // Replace with your actual URL
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        _questions[_currentQuestionIndex].question,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Display the answer choices as buttons
                  for (var answer in _questions[_currentQuestionIndex].allAnswers)
                    ElevatedButton(
                      onPressed: () => _checkAnswer(answer),
                      child: Text(
                        answer,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  SizedBox(height: 16),
                  // Display the current score
                  Text(
                    'Score: $_score',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
