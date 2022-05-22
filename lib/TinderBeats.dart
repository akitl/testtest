import 'package:tinder_nft/GameSystme/Beat_Sequence.dart';
import 'package:tinder_nft/GameSystme/GameManager.dart';
import 'package:tinder_nft/GameSystme/Steady_Start_component.dart';

import 'package:flame/game.dart';
import 'package:flame/effects.dart';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class TinderBeats2 extends FlameGame with FPSCounter, HasTappables {
  late BeatSequence bs;
  double time = 0;
  double waitingTime = 2;
  bool onPlay = false;
  List<BeatSequence> beatSequences = [];
  int actualSequence = 0;

  final _shaded = TextPaint(
    style: TextStyle(
      color: BasicPalette.white.color,
      fontSize: 40.0,
      shadows: const [
        Shadow(color: Colors.red, offset: Offset(2, 2), blurRadius: 2),
        Shadow(color: Colors.yellow, offset: Offset(4, 4), blurRadius: 4),
      ],
    ),
  );

  void StartRun() {
    onPlay = true;
    time = 0;
  }

  @override
  void onMount() {
    camera.viewport = FixedResolutionViewport(Vector2(600, 850));
  }

  Future<void> onLoad() async {
    add(GameManager());
    beatSequences.add(BeatSequence(Vector2(600, 850), 2, 2, 0.5, 15));
    beatSequences.add(BeatSequence(Vector2(600, 850), 1.8, 1.5, 0.5, 15));
    beatSequences.add(BeatSequence(Vector2(600, 850), 1.5, 1, 0.5, 15));
    beatSequences.add(BeatSequence(Vector2(600, 850), 1.5, 1, 0.5, 15));
    beatSequences.add(BeatSequence(Vector2(600, 850), 1.5, 1, 0.5, 15));
    beatSequences.add(BeatSequence(Vector2(600, 850), 1.5, 1, 0.5, 15));
    actualSequence = 0;
    bs = beatSequences[actualSequence];
    TextComponent tc = TextComponent(text: '0', textRenderer: _shaded)
      ..position = size - Vector2(-100,800);
    add(tc);
    GameManager().scoreUi = tc;
    GameManager().game = this;
    add(SteadyStart());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (bs.runFinished) {
      print("runFinished");
      onPlay = false;
      // time += dt;

      actualSequence++;
      bs = beatSequences[actualSequence];
      add(SteadyStart());
    }

    if (onPlay) {
      time += dt;
      if (time > bs.intervalToNext && bs.actualBeat < bs.beats.length) {
        time = 0;
        int temp = bs.NextBeat();
        if (temp == -1) {
        } else {
          add(bs.beats[temp]
            ..add(
              ScaleEffect.to(
                Vector2.all(1.2),
                InfiniteEffectController(
                  SequenceEffectController([
                    LinearEffectController(0.2),
                    ReverseLinearEffectController(0.5),
                  ]),
                ),
              ),
            ));
        }
      }
    }
  }
}

