import 'package:flutter/foundation.dart';
import 'dart:async';

class TimedGameProvider extends ChangeNotifier {
  int time_sec = 300;
  int correct = 0;
  int incorrect = 0;
  bool finished = false;
  Timer ticker;

  static const timeout = Duration(seconds: 1);

  /*Timer startTimeout() {
    var duration = timeout;
    return Timer(duration, handleTimeout);
  }*/
  @override
  /*void initState() {
    ticker = Timer.periodic(timeout, (timer) {
      this.tic();
    });
  }*/

  void handleTimeout() {
    // callback function
    this.tic();
  }

  @override
  void dispose() {
    ticker.cancel();
    super.dispose();
  }

  void restart(int time) {
    this.time_sec = time;
    this.correct = 0;
    this.incorrect = 0;
    this.finished = false;
  }

  void checkAnswer(bool truth) {
    if (truth) this.correct++;
    if (!truth) this.incorrect++;
    notifyListeners();
  }

  void incrementCorrect() {
    correct++;
    notifyListeners();
  }

  void incrementIncorrect() {
    incorrect++;
    notifyListeners();
  }

  void tic() {
    time_sec--;
    if (time_sec < 1) {
      finished = true;
      ticker.cancel();
    }
    notifyListeners();
  }

  TimedGameProvider(int time) {
    this.time_sec = time;
    ticker = Timer.periodic(timeout, (Timer timer) {
      handleTimeout();
    });
  }
}
