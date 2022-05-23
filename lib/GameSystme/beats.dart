import 'package:tinder_nft/GameSystme/GameManager.dart';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/effects.dart';

class Beats2 extends SpriteComponent with Tappable, Draggable {
  Vector2 pos = Vector2.zero();
  int number = 0;
  double lifeTime = 0;
  double halfSize = 25;
  double beatTiming = 0;
  double time = 0;
  bool beatLost = false;
  bool win = false;

  // creates a component that renders the crate.png sprite, with size 16 x 16
  Beats2(Vector2 position, this.number, this.lifeTime)
      : super(size: Vector2.all(100)) {
    pos = position;
  }

  Future<void> onLoad() async {
    halfSize = size.x / 2;
    sprite = await Sprite.load('beats.png');
    add(TextComponent(text: number.toString())
      ..anchor = Anchor.center
      ..x = halfSize // size is a property from game
      ..y = halfSize);
  }

  void SetPostion(Vector2 p) {
    pos = p;
    position = Vector2(pos.x - halfSize, pos.y - halfSize);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    if (!beatLost) {
      String t = GameManager().computeScore(
          lifeTime - time, center.distanceTo(info.eventPosition.game));
      win = true;
      add(TextComponent(text: t)
        ..anchor = Anchor.center
        ..x = halfSize * 2 // size is a property from game
        ..y = halfSize * 2);

      //add(OpacityEffect.to(0, EffectController(duration: 0.4)));
      //add(RemoveEffect(delay: 0.5));
      return true;
    } else {
      return false;
    }
  }

  void update(double dt) {
    super.update(dt);
    time += dt;
    if (time > lifeTime && !win) {
      beatLost = true;
      add(TextComponent(text: "bad")
        ..anchor = Anchor.center
        ..x = halfSize * 2 // size is a property from game
        ..y = halfSize * 2);
      add(OpacityEffect.to(0, EffectController(duration: 0.4)));
      add(RemoveEffect(delay: 0.5));
    }

    if (lunched){
      position += lunchedVelocity * dt;
    }
  }

  Vector2? dragDeltaPosition;
  bool get isDragging => dragDeltaPosition != null;
  bool lunched = false;
  Vector2 lunchedVelocity = Vector2.zero();


  bool onDragStart(DragStartInfo startPosition) {
    dragDeltaPosition = startPosition.eventPosition.game - position;
    return false;
  }

  @override
  bool onDragUpdate(DragUpdateInfo event) {
    if (isDragging) {
      final localCoords = event.eventPosition.game;
      position = localCoords - dragDeltaPosition!;
    }
    return false;
  }

  @override
  bool onDragEnd(DragEndInfo event) {
    dragDeltaPosition = null;
    lunched = true;
    lunchedVelocity = event.velocity;
    return false;
  }
}
