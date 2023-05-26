import 'package:flutter/material.dart';
import '../models/trivia_question.dart';
import 'package:trivia_app/services/api_service.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'GameOverScreen.dart';
import 'package:audioplayers/audioplayers.dart';

class GameScreen extends StatefulWidget {
  final String category;

  GameScreen({required this.category});

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

  void _loadTriviaQuestions() async {
    _questions = await _apiService.fetchTriviaQuestions(widget.category);
    for (var question in _questions) {
      question.question = HtmlCharacterEntities.decode(question.question);
    }
    setState(() {});
  }

  void _checkAnswer(String selectedAnswer) {
    if (_questions[_currentQuestionIndex].correctAnswer == selectedAnswer) {
      _score++;
    } else {
      _gameEnded = true;
      _playMusic("sonne.mp3"); // Play the "sonne.mp3" song on the GameScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GameOverScreen(
            score: _score,
            category: widget.category,
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
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_gameEnded) {
      return Scaffold(
        body: GameOverScreen(
          score: _score,
          category: widget.category,
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
      return CircularProgressIndicator();
    } else {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1579546929662-711aa81148cf'),
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
                  for (var answer
                      in _questions[_currentQuestionIndex].allAnswers)
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
                        primary: Colors.blue,
                      ),
                    ),
                  SizedBox(height: 16),
                  Text(
                    'Score: $_score',
                    style: TextStyle(fontSize: 24, color: Colors.white),
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
