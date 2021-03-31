import 'package:flutter/material.dart';
import 'package:math_game/routes/route_args.dart';
import 'package:math_game/routes/routenames.dart';

class Home extends StatelessWidget {
  List<String> Games = [
    RouteNames.add,
    RouteNames.addMultiply,
    RouteNames.decimalAdd
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Game'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: Games.map<Widget>((game) => Container(
              decoration: BoxDecoration(
                color: Colors.blue[100],
                border: Border.all(
                  color: Colors.blue[700],
                  width: 3.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(game,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.black87,
                      )),
                  IconButton(
                    icon: Icon(Icons.play_arrow),
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.game_settings,
                          arguments: SettingsArgs(game));
                    },
                  ),
                ],
              ),
            )).toList(),
      ),
    );
  }
}
