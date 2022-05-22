import 'package:flame/components.dart';

import 'package:tinder_nft/TinderBeats.dart';

class GameManager extends Component {
  static final GameManager _singleton = GameManager._internal();

  factory GameManager() {
    return _singleton;
  }
  GameManager._internal();

  int score = 0;
  late TextComponent scoreUi;
  late TinderBeats2 game;

  String computeScore(double timeDif, double centrerDif) {
    int s = 0;
    String t = "";
    int resTime = 0;
    if (timeDif < 0.5) {
      resTime = 0;
      s = 10;
    } else if (timeDif < 1.1) {
      resTime = 1;
      s = 25;
    } else if (timeDif < 1.5) {
      resTime = 2;
      s = 50;
    }

    int resCenter = 0;
    if (centrerDif <= 12) {
      resCenter = 2;
      s += 50;
    } else if (centrerDif <= 25) {
      resCenter = 1;
      s += 25;
    } else if (centrerDif < 80) {
      resCenter = 0;
      s += 10;
    }

    switch (resTime * resCenter) {
      case 0:
        t = "ok !";
        break;
      case 1 :
        t = "Cool !";
        break;
      case 2:
        t = "Cool !";
        break; 
      case 4:
        t = "Perfect !";
        break;
      default:
    }

    print(centrerDif);
    print(timeDif);
    score += s;
    scoreUi.text = '$score';
    return t;
  }
}
