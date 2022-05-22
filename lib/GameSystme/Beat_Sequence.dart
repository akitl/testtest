import 'dart:math';

import 'package:flame/game.dart';

import 'package:tinder_nft/GameSystme/beats.dart';


class BeatSequence {
  List<Beats2> beats = [];
  double beatsLifeTime = 0;
  double intervalMax = 0;
  double intervalMin = 0;
  Vector2 size = Vector2.zero();
  int actualBeat = 0;
  double intervalToNext = 0;
  bool runFinished = false;

  BeatSequence(this.size, this.beatsLifeTime, this.intervalMax,
      this.intervalMin, int sequenceLenght) {
    for (int i = 0; i < sequenceLenght; i++) {
      // generate random vector2 position in the screen
      Vector2 pos = Vector2(Random().nextDouble() * (size.x - 50),
          Random().nextDouble() * (size.y - 50));
      beats.add(Beats2(pos, i, beatsLifeTime));
      beats[i].SetPostion(pos);
    }

    //get a random value between the intervalMax and intervalMin
    intervalToNext =
        Random().nextDouble() * (intervalMax - intervalMin) + intervalMin;
  }

  int NextBeat() {
    if (actualBeat+1 == beats.length) {
      runFinished = true;
      return -1;
    } else {
      actualBeat++;
      intervalToNext =
          Random().nextDouble() * (intervalMax - intervalMin) + intervalMin;
          return actualBeat-1;
    }
  }
}
