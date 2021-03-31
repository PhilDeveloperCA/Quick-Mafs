import 'package:flutter/material.dart';
import 'package:math_game/routes/route_generator.dart';
import 'package:math_game/routes/routenames.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
