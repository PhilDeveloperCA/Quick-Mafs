import 'package:flutter/material.dart';
import 'package:math_game/routes/route_args.dart';

List<String> difficulties = ['Easy', 'Medium', 'Hard', 'Extreme'];
List<int> times = [2, 3, 5];
List<int> lengths = [15, 25, 45, 60];
List<String> modes = ['Timed', 'Numbered'];
List<String> games = ['Add-Multiply'];

class GameSettings extends StatefulWidget {
  final SettingsArgs settings;
  GameSettings(this.settings);
  @override
  _GameSettingsState createState() => _GameSettingsState();
}

class _GameSettingsState extends State<GameSettings> {
  @override
  String difficulty = difficulties[1];
  String mode = modes[0];
  int time = times[1];
  int length = lengths[1];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Choose Game Settings : ')),
        automaticallyImplyLeading: true,
      ),
      body: Form(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(bottom: 12.0, left: 25.0),
                  child: Text(
                    'Choose Difficulty : ',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              DropdownButton(
                items: difficulties
                    .map(
                      (difficulty) => DropdownMenuItem(
                        child: Text(difficulty),
                        value: difficulty,
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    this.difficulty = value;
                  });
                },
                value: this.difficulty,
              ),
            ],
          ),
          Center(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 12.0, left: 25.0),
                    child: Text(
                      'Choose Gameplay Mode :',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          this.mode = modes[0];
                        });
                      },
                      child: Text(
                        'Timed',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: this.mode == modes[0]
                                ? FontWeight.bold
                                : FontWeight.w200),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          this.mode = modes[1];
                        });
                      },
                      child: Text(
                        'Numbered',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: this.mode == modes[1]
                                ? FontWeight.bold
                                : FontWeight.w200),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          if (this.mode == 'Timed')
            Column(
              children: [
                Text('Select Game Time (minutes) : '),
                DropdownButton(
                    value: time,
                    items: times
                        .map((time) => DropdownMenuItem(
                              child: Text('$time'),
                              value: time,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        this.time = value;
                      });
                    }),
              ],
            )
          else
            Column(
              children: [
                Text(' Select # of Questions : '),
                DropdownButton(
                    value: length,
                    items: lengths
                        .map(
                          (length) => DropdownMenuItem(
                            child: Text('$length'),
                            value: length,
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        this.length = value;
                      });
                    }),
              ],
            ),
          IconButton(
            iconSize: 36.0,
            highlightColor: Colors.blue[100],
            color: Colors.blue[500],
            onPressed: () {
              Navigator.pushNamed(context, '${widget.settings.gamename}',
                  arguments: new GameArgs(mode, difficulty, time));
            },
            icon: Icon(Icons.play_arrow),
          ),
        ]),
      ),
    );
  }
}
