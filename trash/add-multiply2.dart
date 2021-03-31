import 'dart:async';

import 'package:flutter/material.dart';
import 'package:math_game/models/add_multiply.dart';
import 'package:math_game/routes/route_args.dart';
import 'package:math_game/routes/routenames.dart';
import 'package:provider/provider.dart';

class AddMultiply extends StatefulWidget {
  final GameArgs game;
  int seconds;

  AddMultiply(this.game) {
    seconds = game.mode == 'Timed' ? game.time * 60 : 0;
    print(seconds);
  }

  _AddMultiplyState createState() => _AddMultiplyState();
}

class _AddMultiplyState extends State<AddMultiply> {
  int correct = 0;
  int incorrect = 0;
  Timer ticker;

  final Duration timeout = new Duration(seconds: 1);

  handleTic() {
    widget.game.mode == 'Timed' ? widget.seconds-- : widget.seconds++;
    setState(() {
      widget.seconds = widget.seconds;
      print(widget.seconds);
    });
  }

  startTimer() {}

  @override
  void initState() {
    super.initState();
    ticker = Timer(timeout, () {
      handleTic();
    });
  }

  @override
  void dispose() {
    ticker.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddMultiplyProvider>(
      create: (context) => AddMultiplyProvider(widget.game.difficulty),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Text('Add-Multiply Game'),
        ),
        body: Column(
          children: [
            timerWidget(context),
            answerWidget(),
            RowButtons(context),
          ],
        ),
      ),
    );
  }

  Widget timerWidget(BuildContext context) {
    AddMultiplyProvider thisgame =
        Provider.of<AddMultiplyProvider>(context, listen: false);
    if (widget.game.mode == 'Timed') {
      String secondsString = widget.seconds % 60 < 10
          ? '0${widget.seconds % 60}'
          : '${widget.seconds % 60}';
      if (widget.seconds < 1)
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      ' Correct : ${this.correct}',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      ' Incorrect : ${this.incorrect}',
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
                '${widget.seconds ~/ 60} : ${widget.seconds}',
                style: TextStyle(
                  fontSize: 20.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                  color:
                      widget.seconds < 10 ? Colors.red[500] : Colors.blue[500],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  thisgame.VerifyAnswer();
                },
              ),
            )
          ],
        );
      else {
        return Container(
          child: IconButton(
            icon: Icon(Icons.skip_next_outlined),
            onPressed: () {
              thisgame.dispose();
              Navigator.pushNamed(context, RouteNames.home);
            },
          ),
        );
      }
      ;
    } else {
      if (widget.seconds > 0)
        return Text('${widget.seconds ~/ 60} : ${widget.seconds % 60}');
      else {
        return Container(
          child: IconButton(
            icon: Icon(Icons.skip_next_outlined),
            onPressed: () {
              thisgame.dispose();
              Navigator.pushNamed(context, RouteNames.home);
            },
          ),
        );
      }
    }
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (model.currentQuestion.mode == 1)
              Text(
                  '(${convertString(model.answers[0])} +  ${convertString(model.answers[1])}) X ${convertString(model.answers[2])} = ${model.currentQuestion.ans}')
            else if (model.currentQuestion.mode == 2)
              Text(
                  '${convertString(model.answers[0])} + ${convertString(model.answers[1])} X ${convertString(model.answers[2])} = ${model.currentQuestion.ans}')
            else if (model.currentQuestion.mode == 3)
              Text(
                  '(${convertString(model.answers[0])} - ${convertString(model.answers[1])}) X  ${convertString(model.answers[2])} = ${model.currentQuestion.ans}')
            else
              Text(
                  '${convertString(model.answers[0])} - ${convertString(model.answers[1])} X ${convertString(model.answers[2])} = ${model.currentQuestion.ans}')
          ],
        ),
      ),
    );
  }

  Widget RowButtons(BuildContext context) {
    int rows = this.widget.game.difficulty == 'extreme'
        ? 5
        : this.widget.game.difficulty == 'hard'
            ? 4
            : this.widget.game.difficulty == 'medium'
                ? 3
                : 2;
    final game = Provider.of<AddMultiplyProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 36.0,
          icon: Icon(Icons.delete),
          color: Colors.red[300],
          onPressed: () {
            game.depend();
          },
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
}
