import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/MainMenu.dart';
import 'screens/SettingsScreen.dart';
import 'package:trivia_app/models/Settings.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppSettings(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppSettings>(create: (_) => AppSettings()),
      ],
      child: MaterialApp(
        title: 'Trivia App',
        home: MainMenu(),
      ),
    );
  }
}

class QuestionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var settings = Provider.of<AppSettings>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Trivia App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Question goes here',
              style: TextStyle(
                fontSize: settings.textSize,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultScreen()),
                );
              },
              child: Text('Option 1'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultScreen()),
                );
              },
              child: Text('Option 2'),
            ),
            // Add more options as needed
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Center(
        child: Text('Answer goes here'),
      ),
    );
  }
}
