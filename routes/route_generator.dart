import 'package:flutter/material.dart';
import 'package:math_game/routes/routenames.dart';
import 'package:math_game/views/add_multiply.dart';
import 'package:math_game/views/home.dart';
import 'package:math_game/views/game_settings.dart';
import 'package:math_game/views/results.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => Home());
      case RouteNames.game_settings:
        return MaterialPageRoute(builder: (_) => GameSettings(args));
      case RouteNames.addMultiply:
        return MaterialPageRoute(builder: (_) => AddMultiply(args));
      case RouteNames.results:
        return MaterialPageRoute(builder: (_) => Results(args));
    }
  }
}
