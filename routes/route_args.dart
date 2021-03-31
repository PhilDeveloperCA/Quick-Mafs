class SettingsArgs {
  String gamename;
  SettingsArgs(this.gamename);
}

class GameArgs {
  String mode;
  String difficulty;
  int time; //depending on one, default is 0, just start with timed first
  int length;
  GameArgs(this.mode, this.difficulty, this.time);
}

class ResultArgs {
  String game;
  String difficulty;
  String mode;
  int length;
  int time;
  ResultArgs(this.game, this.difficulty, this.mode, this.length, this.time);
}
