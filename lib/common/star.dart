import 'dart:math';

import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:spaceshooter/game_manager.dart';

class Star extends SpriteAnimationComponent with HasGameRef<GameManager> {
  @override
  Future<void>? onLoad() {
    var size = Random().nextInt(10).toDouble() + 10;
    var x = Random()
        .nextInt((gameRef.size.toRect().width - size).toInt())
        .toDouble();
    var y = Random()
        .nextInt((gameRef.size.toRect().height - size).toInt())
        .toDouble();

    width = size;
    height = size;
    position = Vector2(x, y);
    anchor = Anchor.center;
  }
}