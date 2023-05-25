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
  AudioPlayer _audioPlayer = AudioPlayer();
  bool _isMusicPlaying = false;

  @override
  void initState() {
    super.initState();
    _playMusic("amerika.mp3"); // Play the "amerika.mp3" song on the MainMenu
  }

  Future<void> _playMusic(String musicPath) async {
    await _audioPlayer.stop();
    await _audioPlayer.play("assets/$musicPath", isLocal: true);
    setState(() {
      _isMusicPlaying = true;
    });
  }

  void _toggleMusic() {
    if (_isMusicPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.resume();
    }
    setState(() {
      _isMusicPlaying = !_isMusicPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
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
                    'Arts'
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
              SizedBox(height: 10),
              IconButton(
                icon: Icon(
                  _isMusicPlaying ? Icons.music_note : Icons.music_off,
                  color: Colors.white,
                ),
                onPressed: _toggleMusic,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
