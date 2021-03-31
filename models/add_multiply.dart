import 'package:flutter/foundation.dart';
import 'dart:math';

class Question {
  int ans;
  int mode;
  Question(this.ans, this.mode);
}

class AddMultiplyProvider extends ChangeNotifier {
  int range = 8;
  Question currentQuestion = new Question(2, 1);
  List<int> answers = [0, 0, 0];
  int active = 0;
  Random random = new Random();

  get modeOpp => [];

  initState() {
    generateQuestion();
  }

  AddMultiplyProvider(String difficulty) {
    currentQuestion = new Question(2, 1);
    if (difficulty == null) difficulty = 'medium';
    if (difficulty == 'Extreme') {
      this.range = 14;
    }
    if (difficulty == 'Hard') {
      this.range = 11;
    }
    if (difficulty == 'Medium') {
      this.range = 8;
    }
    if (difficulty == 'Easy') {
      this.range = 5;
    }
  }

  void generateQuestion() {
    int N1 = random.nextInt(range) + 1;
    int N2 = random.nextInt(range) + 1;
    int N3 = random.nextInt(range) + 1;
    int mode = random.nextInt(3) + 1;
    List<int> answerList = [N1, N2, N3];
    int answer = modeAnswer(answerList, mode);
    this.currentQuestion = Question(answer, mode);
    //return new Question(32, 2);
  }

  static modeAnswer(List<int> ans, mode) {
    //(a+b)*c
    //a+b*c
    //(a-b)*c
    //a-b*c
    if (mode == 1) {
      return (ans[0] + ans[1]) * ans[2];
    }
    if (mode == 2) {
      return ans[0] + ans[1] * ans[2];
    }
    if (mode == 3) {
      return (ans[0] - ans[1]) * ans[2];
    }
    if (mode == 4) {
      return ans[0] - ans[1] * ans[2];
    }
  }

  void append(int ans) {
    if (active < 3) {
      answers[active] = ans;
      active++;
    }
    notifyListeners();
  }

  void depend() {
    if (active == 2) {
      answers[2] = 0;
      active = 2;
    }
    if (active > 0) {
      active--;
      answers[active] = 0;
    } else {
      answers[0] = 0;
    }
    notifyListeners();
  }

  bool VerifyAnswer() {
    bool me;
    if (modeAnswer(answers, currentQuestion.mode) == currentQuestion.ans)
      me = true;
    else
      me = false;
    this.answers = [0, 0, 0];
    active = 0;
    this.generateQuestion();
    notifyListeners();
    return me;
  }
}
