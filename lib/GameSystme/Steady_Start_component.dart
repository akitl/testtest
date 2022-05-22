import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/palette.dart';

import 'package:flutter/material.dart';

import 'package:tinder_nft/GameSystme/GameManager.dart';

class SteadyStart extends Component {
  final _shaded = TextPaint(
    style: TextStyle(
      color: BasicPalette.white.color,
      fontSize: 50.0,
      shadows: const [
        Shadow(
            color: Color.fromARGB(255, 221, 50, 38),
            offset: Offset(2, 2),
            blurRadius: 2),
        Shadow(
            color: Color.fromARGB(255, 11, 102, 155),
            offset: Offset(4, 4),
            blurRadius: 4),
      ],
    ),
  );
  double time = 0;
  double timing1 = 0.8;
  double timing2 = 1.6;
  bool timing1Pass = false;
  bool timing2Pass = false;

  @override
  Future<void>? onLoad() {
    print("object ");
    EffectController duration(double x) => EffectController(duration: x);
    TextComponent tc = TextComponent(text: 'Ready ?', textRenderer: _shaded)
      ..position = Vector2(200, 150);
    add(tc
      ..add(MoveEffect.to(Vector2(200, 250), duration(0.6)))
      ..add(RemoveEffect(delay: 0.9)));
  }

  @override
  void update(double dt) {
    super.update(dt);
    time += dt;
    if (time > timing1 && !timing1Pass) {
      timing1Pass = true;
      add(TextComponent(text: 'Steady', textRenderer: _shaded)
        ..position = Vector2(200, 150)
        ..add(MoveEffect.to(Vector2(200, 250), EffectController(duration: 0.6)))
        ..add(RemoveEffect(delay: 0.9)));
    }
    if (time > timing2 && timing1Pass && !timing2Pass) {
      timing2Pass = true;
      add(TextComponent(text: 'Go !', textRenderer: _shaded)
        ..position = Vector2(220, 150)
        ..add(MoveEffect.to(Vector2(220, 250), EffectController(duration: 0.6)))
        ..add(RemoveEffect(delay: 0.9)));
    } else if (timing1Pass && timing2Pass && time > timing2 + 0.9) {
      GameManager().game.StartRun();
      GameManager().game.remove(this);
    }
  }
}
