import 'dart:math';

import 'player.dart';

import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';

import '../game_manager.dart';
import 'bullet.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameRef<GameManager>, HasHitboxes, Collidable {
  final double _speed = 250;

  final Function(Vector2) onTouch;
  var hitboxRectangle = HitboxRectangle();

  Enemy(this.onTouch);

  @override
  Future<void>? onLoad() async {
    var spriteSheet = SpriteSheet(image: await Images().load("green_red.png"), srcSize: Vector2(17.0, 17.0));
    animation = spriteSheet.createAnimation(row: Random().nextInt(2), stepTime: 0.2);
    //animation = spriteSheet.createAnimation(row: 1, stepTime: 0.2);
    var size = 40.0;
    position = Vector2(300+Random().nextInt(2).toDouble()*300, size);
    width = size;
    height = size;
    anchor = Anchor.center;

    addHitbox(hitboxRectangle);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      removeFromParent();
      removeHitbox(hitboxRectangle);
      onTouch.call(other.position);
    }
  }

  void move(Vector2 delta) {
    position.add(delta);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, 1) * _speed * dt;
    if (position.y > gameRef.size.y) {
      removeFromParent();
      removeHitbox(hitboxRectangle);
    }
  }
}
