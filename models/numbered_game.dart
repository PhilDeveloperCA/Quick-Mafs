import 'dart:async';

import 'package:flutter/foundation.dart';

class NumberedGameProvider extends ChangeNotifier {
  int incorrect = 0;
  int correct = 0;
  int time_sec = 0;
  bool finished = false;
  int current = 0;
  int length = 0;
  Timer ticker;

  NumberedGameProvider(this.length) {
    ticker = Timer.periodic(timeout, (Timer timer) {
      handleTimeout();
    });
  }

  static const timeout = Duration(seconds: 1);

  startTimeout() {
    var duration = timeout;
    ticker = Timer(timeout, handleTimeout);
  }

  void handleTimeout() {
    // callback function
    this.tic();
  }

  void restart() {
    this.correct = 0;
    this.incorrect = 0;
    this.time_sec = 0;
  }

  void checkAnswer(bool correct) {
    if (correct)
      this.correct++;
    else
      this.incorrect++;
    this.current++;
    if (current >= length) {
      this.finished = true;
    }
    notifyListeners();
  }

  void incrimentCorrect() {
    this.correct++;
    if (correct <= 25) {
      finished = true;
    }
    notifyListeners();
  }

  void incrimentIncorrect() {
    this.incorrect++;
    notifyListeners();
  }

  void tic() {
    this.time_sec++;
    notifyListeners();
  }
}
