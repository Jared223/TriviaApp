import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'SettingsScreen.dart';
import 'LeaderboardScreen.dart';
import 'CopyrightScreen.dart';
import 'GameScreen.dart';
import 'package:trivia_app/models/Settings.dart';
import 'package:audioplayers/audioplayers.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String selectedCategory = 'General Knowledge';
  final player = AudioPlayer();
  bool isMusicPlaying = true;

  @override
  void initState() {
    super.initState();
    player.play(AssetSource('audios/amerika.mp3'));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void toggleMusic() {
    if (isMusicPlaying) {
      player.setVolume(0.0);
    } else {
      player.setVolume(1.0);
    }
    setState(() {
      isMusicPlaying = !isMusicPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trivia App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: Icon(
            Icons.music_note,
            color: Colors.white,
          ),
          onPressed: toggleMusic,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CopyrightScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Colors.red],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton<String>(
                  value: selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  items: <String>[
                    'General Knowledge',
                    'Science',
                    'History',
                    'Geography',
                    'Arts',
                    'Books', // Added 'Books' category
                    'Video Games', // Added 'Video Games' category
                    'Animals', // Added 'Animals' category
                    'Television',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              Consumer<AppSettings>(
                builder: (context, settings, _) {
                  return Text(
                    'Ready to conquer the trivia world?',
                    style: TextStyle(
                      fontSize: settings.textSize,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico',
                      color: Colors.white,
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Consumer<AppSettings>(
                builder: (context, settings, _) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GameScreen(category: selectedCategory),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Start Game',
                        style: TextStyle(
                          fontSize: settings.textSize,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              Consumer<AppSettings>(
                builder: (context, settings, _) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsScreen()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: settings.textSize,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              Consumer<AppSettings>(
                builder: (context, settings, _) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LeaderboardScreen()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Leaderboard',
                        style: TextStyle(
                          fontSize: settings.textSize,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
