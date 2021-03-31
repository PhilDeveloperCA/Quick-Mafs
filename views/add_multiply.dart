import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:math_game/models/add_multiply.dart';
import 'package:math_game/models/numbered_game.dart';
import 'package:math_game/models/timed_game.dart';
import 'package:math_game/routes/route_args.dart';
import 'package:math_game/routes/routenames.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class AddMultiply extends StatefulWidget {
  final GameArgs game;

  AddMultiply(this.game) {
    int rows = this.game.difficulty == 'extreme'
        ? 5
        : this.game.difficulty == 'hard'
            ? 4
            : this.game.difficulty == 'medium'
                ? 3
                : 2;
  }

  @override
  _AddMultiplyState createState() => _AddMultiplyState();
}

class _AddMultiplyState extends State<AddMultiply> {
  int rows;
  int correct;
  int incorrect;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add-Multiply'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<AddMultiplyProvider>(
              create: (context) =>
                  AddMultiplyProvider(this.widget.game.difficulty),
            ),
            ChangeNotifierProvider<NumberedGameProvider>(
                create: (context) =>
                    NumberedGameProvider(this.widget.game.length)),
            ChangeNotifierProvider<TimedGameProvider>(
                create: (context) =>
                    TimedGameProvider(this.widget.game.time * 60)),
          ],
          builder: (context, child) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              gameClock(context), //RowButtons(context)
              answerWidget(),
              rowButtons(context),
              handleRow(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget gameClock(BuildContext context) {
    AddMultiplyProvider thisgame =
        Provider.of<AddMultiplyProvider>(context, listen: false);

    TimedGameProvider manager =
        Provider.of<TimedGameProvider>(context, listen: false);
    String handleSeconds(int seconds) {
      if (seconds > 9)
        return '$seconds';
      else
        return '0$seconds';
    }

    bool handleSubmit() {
      bool me = thisgame.VerifyAnswer();
      //thisgame.generateQuestion();
      //thisgame.generateQuestion(thisgame.range);
      return me;
    }

    if (widget.game.mode == 'Timed') {
      return Consumer<TimedGameProvider>(builder: (context, model, child) {
        String seconds = model.time_sec % 60 < 10
            ? '0${model.time_sec % 60}'
            : '${model.time_sec % 60}';
        if (!model.finished)
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        ' Correct : ${model.correct}',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        ' Incorrect : ${model.incorrect}',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  '${model.time_sec ~/ 60} : ${handleSeconds(model.time_sec % 60)}',
                  style: TextStyle(
                    fontSize: 20.0,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                    color: model.time_sec < 10
                        ? Colors.red[500]
                        : Colors.blue[500],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    model.checkAnswer(handleSubmit());
                  },
                ),
              )
            ],
          );
        else {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'See Results',
                  style: TextStyle(
                    color: Colors.red[300],
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: IconButton(
                  iconSize: 36.0,
                  icon: Icon(Icons.skip_next_outlined),
                  onPressed: () {
                    model.dispose();
                    Navigator.pushNamed(context, RouteNames.home);
                  },
                ),
              ),
            ],
          );
        }
      });
    } else {
      return Consumer<NumberedGameProvider>(builder: (context, model, child) {
        String seconds = model.time_sec % 60 < 10
            ? '0${model.time_sec % 60}'
            : '${model.time_sec % 60}';
        if (!model.finished)
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        ' Correct : ${model.correct}',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        ' Incorrect : ${model.incorrect}',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  '${model.time_sec ~/ 60} : ${handleSeconds(model.time_sec % 60)}',
                  style: TextStyle(
                    fontSize: 20.0,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                    color: model.time_sec < 10
                        ? Colors.red[500]
                        : Colors.blue[500],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Submit Results : ',
                      style: TextStyle(
                        color: Colors.blue[400],
                        letterSpacing: 2.0,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () {
                        model.checkAnswer(handleSubmit());
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        else {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  'See Results',
                  style: TextStyle(
                    color: Colors.red[300],
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: IconButton(
                  iconSize: 36.0,
                  icon: Icon(Icons.skip_next_outlined),
                  onPressed: () {
                    model.dispose();
                    Navigator.pushNamed(context, RouteNames.results,
                        arguments: new ResultArgs(
                            'Add-Multiply',
                            widget.game.difficulty,
                            widget.game.mode,
                            widget.game.length,
                            widget.game.time));
                  },
                ),
              ),
            ],
          );
        }
      });
    }
  }

  Widget rowButtons(BuildContext context) {
    int rows = this.widget.game.difficulty == 'Extreme'
        ? 5
        : this.widget.game.difficulty == 'Hard'
            ? 4
            : this.widget.game.difficulty == 'Medium'
                ? 3
                : 2;
    final game = Provider.of<AddMultiplyProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Erase : ',
                style: TextStyle(
                  color: Colors.red[300],
                  fontSize: 16.0,
                ),
              ),
              IconButton(
                iconSize: 36.0,
                icon: Icon(Icons.delete),
                color: Colors.red[300],
                onPressed: () {
                  game.depend();
                },
              ),
            ],
          ),
        ),
        for (int i = 0; i < rows; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.blue[400],
                  width: 2.0,
                )),
                child: TextButton(
                  child: Text('${i * 3 + 1}',
                      style: TextStyle(
                        color: Colors.blue[500],
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      )),
                  onPressed: () {
                    game.append(i * 3 + 1);
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.blue[400],
                  width: 2.0,
                )),
                child: TextButton(
                  child: Text('${i * 3 + 2}',
                      style: TextStyle(
                        color: Colors.blue[500],
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      )),
                  onPressed: () {
                    game.append(i * 3 + 2);
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.blue[400],
                  width: 2.0,
                )),
                child: TextButton(
                  child: Text('${i * 3 + 3}',
                      style: TextStyle(
                        color: Colors.blue[500],
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      )),
                  onPressed: () {
                    game.append(i * 3 + 3);
                  },
                ),
              )
            ],
          )
      ],
    );
  }

  Widget answerWidget() {
    String convertString(int number) {
      if (number == 0)
        return '_';
      else
        return '$number';
    }

    return Consumer<AddMultiplyProvider>(
      builder: (context, model, child) => Container(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (model.currentQuestion.mode == 1)
                Text(
                  '(${convertString(model.answers[0])}  +  ${convertString(model.answers[1])} ) X  ${convertString(model.answers[2])} = ${model.currentQuestion.ans}',
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                  ),
                )
              else if (model.currentQuestion.mode == 2)
                Text(
                  '${convertString(model.answers[0])} + ${convertString(model.answers[1])} X ${convertString(model.answers[2])} = ${model.currentQuestion.ans}',
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                  ),
                )
              else if (model.currentQuestion.mode == 3)
                Text(
                  '(${convertString(model.answers[0])} - ${convertString(model.answers[1])} ) X  ${convertString(model.answers[2])} = ${model.currentQuestion.ans}',
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                  ),
                )
              else
                Text(
                  '${convertString(model.answers[0])} - ${convertString(model.answers[1])} X ${convertString(model.answers[2])} = ${model.currentQuestion.ans}',
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget handleRow(BuildContext context) {
    final timedGame = Provider.of<TimedGameProvider>(context);
    final numberedGame = Provider.of<NumberedGameProvider>(context);

    return Container(
      padding: EdgeInsets.only(top: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              timedGame.restart(this.widget.game.time * 60);
              numberedGame.restart();
            },
            child: Icon(Icons.reset_tv),
          ),
          TextButton(
            onPressed: () {
              timedGame.dispose();
              numberedGame.dispose();
              Navigator.pushNamed(context, RouteNames.home);
            },
            child: Icon(Icons.home),
          )
        ],
      ),
    );
  }
}
