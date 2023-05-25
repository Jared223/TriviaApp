import 'package:flutter/foundation.dart';

class AppSettings extends ChangeNotifier {
  double textSize = 20;

  void updateTextSize(double size) {
    textSize = size;
    notifyListeners();
  }
}
