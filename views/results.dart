import 'package:flutter/material.dart';
import 'package:math_game/routes/route_args.dart';

class Results extends StatelessWidget {
  ResultArgs results;
  Results(this.results);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Results'),
      ),
      body: Column(),
    );
  }
}
