import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'GameScreen.dart';
import 'package:trivia_app/models/Settings.dart';

class GameOverScreen extends StatelessWidget {
  final int score;
  final String category;
  final VoidCallback onTryAgain;
  final VoidCallback onBackToMenu;

  GameOverScreen({
    required this.score,
    required this.category,
    required this.onTryAgain,
    required this.onBackToMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettings>(
      builder: (context, settings, _) {
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
                  children: <Widget>[
                    Text(
                      'Game Over',
                      style: TextStyle(
                        fontSize: settings.textSize,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Score: $score',
                      style: TextStyle(
                        fontSize: settings.textSize,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        onTryAgain();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GameScreen(category: category),
                          ),
                        );
                      },
                      child: Text('Try Again'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: onBackToMenu,
                      child: Text('Back to Menu'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
