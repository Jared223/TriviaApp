// Importing required libraries and components.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'GameScreen.dart';
import 'package:trivia_app/models/Settings.dart';


// Defining a stateless widget for the game over screen 
class GameOverScreen extends StatelessWidget {
  // required variables (score and category) and callbacks 
  final int score;
  final String category;
  final VoidCallback onTryAgain;
  final VoidCallback onBackToMenu;

  // constructor for GameOverScreen widget. Intitalises the required parameters
  GameOverScreen({
    required this.score,
    required this.category,
    required this.onTryAgain,
    required this.onBackToMenu,
  });

  // This method describes the part of the user interface represented by this widget.
  @override
  Widget build(BuildContext context) {
    // Consumer widget allows listening to AppSettings
    return Consumer<AppSettings>(
      builder: (context, settings, _) {
        // the layoud for the GameOverScreen is defined here
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                // putting background image
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
                      child: Text('Try Again'), // Displays try again
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
                      child: Text('Back to Menu'), // Displays back to menu
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
